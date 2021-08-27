import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/api_calls/cosmos_wallet_api.dart';
import 'package:flutter_app/data/api_calls/ethereum_wallet_api.dart';
import 'package:flutter_app/data/api_calls/wallet_api.dart';
import 'package:flutter_app/data/emeris/emeris_balances_repository.dart';
import 'package:flutter_app/data/emeris/emeris_transactions_repository.dart';
import 'package:flutter_app/data/emeris/emeris_wallets_repository.dart';
import 'package:flutter_app/data/ethereum/ethereum_credentials_serializer.dart';
import 'package:flutter_app/data/ethereum/ethereum_transaction_signer.dart';
import 'package:flutter_app/data/http/dio_builder.dart';
import 'package:flutter_app/data/web/web_key_info_storage.dart';
import 'package:flutter_app/domain/repositories/balances_repository.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/generate_mnemonic_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_money_use_case.dart';
import 'package:flutter_app/domain/utils/password_manager.dart';
import 'package:flutter_app/domain/utils/wallet_password_retriever.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/presentation/routing/routing_presentation_model.dart';
import 'package:flutter_app/presentation/routing/routing_presenter.dart';
import 'package:flutter_app/presentation/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/presentation/send_money/send_money_presenter.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presenter.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_presenter.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_presenter.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/transaction_summary_ui/mobile_transaction_summary_ui.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_password_retriever/biometric_wallet_password_retriever.dart';
import 'package:flutter_app/ui/pages/wallet_password_retriever/user_prompt_wallet_password_retriever.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:transaction_signing_gateway/alan/alan_transaction_broadcaster.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/key_info_storage.dart';
import 'package:transaction_signing_gateway/mobile/mobile_key_info_storage.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/transaction_summary_ui.dart';
import 'package:wallet_core/wallet_core.dart';

final getIt = GetIt.instance;

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies(BaseEnv baseEnv) {
  getIt.registerSingleton<BaseEnv>(baseEnv);
  _configureGeneralDependencies();
  _configureTransactionSigningGateway();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

void _configureTransactionSigningGateway() {
  getIt.registerFactory<TransactionSummaryUI>(
    () => MobileTransactionSummaryUI(),
  );
  getIt.registerFactory<KeyInfoStorage>(
    () => kIsWeb
        ? WebKeyInfoStorage()
        : MobileKeyInfoStorage(serializers: [
            AlanCredentialsSerializer(),
            EthereumCredentialsSerializer(),
          ]),
  );
  getIt.registerFactory<TransactionSigningGateway>(
    () => TransactionSigningGateway(
      transactionSummaryUI: getIt(),
      infoStorage: getIt(),
      signers: [
        AlanTransactionSigner(),
        EthereumTransactionSigner(getIt()),
      ],
      broadcasters: [
        AlanTransactionBroadcaster(),
      ],
    ),
  );
}

void _configureRepositories() {
  getIt.registerFactory<List<WalletApi>>(
    () => [
      CosmosWalletApi(getIt(), getIt(), getIt()),
      EthereumWalletApi(getIt(), getIt()),
    ],
  );

  getIt.registerFactory<TransactionsRepository>(
    () => EmerisTransactionsRepository(getIt()),
  );
  getIt.registerFactory<WalletsRepository>(
    () => EmerisWalletsRepository(getIt(), getIt()),
  );
  getIt.registerFactory<BalancesRepository>(
    () => EmerisBalancesRepository(getIt()),
  );
}

void _configureStores() {
  getIt.registerLazySingleton<WalletsStore>(
    () => WalletsStore(),
  );
}

void _configureGeneralDependencies() {
  getIt.registerFactory<Web3Client>(
    () => Web3Client(getIt<BaseEnv>().baseEthUrl, Client()),
  );
  getIt.registerLazySingleton<List<WalletPasswordRetriever>>(
    () => [
      UserPromptWalletPasswordRetriever(getIt()),
      BiometricWalletPasswordRetriever(),
    ],
  );

  getIt.registerLazySingleton<PasswordManager>(
    () => PasswordManager(
      BiometricWalletPasswordRetriever(),
      UserPromptWalletPasswordRetriever(getIt()),
    ),
  );

  getIt.registerFactory<DioBuilder>(
    () => DioBuilder(),
  );
  getIt.registerFactory<Dio>(
    () => getIt<DioBuilder>().build(),
  );

  getIt.registerFactory<AppNavigator>(
    () => AppNavigator(),
  );
  getIt.registerFactory<AppInitializer>(
    () => AppInitializer(getIt(), getIt()),
  );
}

void _configureUseCases() {
  getIt.registerFactory<ImportWalletUseCase>(
    () => ImportWalletUseCase(getIt(), getIt()),
  );
  getIt.registerFactory<GetBalancesUseCase>(
    () => GetBalancesUseCase(getIt()),
  );
  getIt.registerFactory<SendMoneyUseCase>(
    () => SendMoneyUseCase(getIt(), getIt()),
  );
  getIt.registerFactory<GenerateMnemonicUseCase>(
    () => GenerateMnemonicUseCase(),
  );
}

void _configureMvp() {
  getIt.registerFactoryParam<WalletsListPresenter, WalletsListPresentationModel, dynamic>(
    (_model, _) => WalletsListPresenter(_model, getIt(), getIt()),
  );
  getIt.registerFactory<WalletsListNavigator>(
    () => WalletsListNavigator(getIt()),
  );
  getIt.registerFactoryParam<WalletDetailsPresenter, WalletDetailsPresentationModel, dynamic>(
    (_model, _) => WalletDetailsPresenter(_model, getIt(), getIt()),
  );
  getIt.registerFactory<WalletDetailsNavigator>(
    () => WalletDetailsNavigator(getIt()),
  );
  getIt.registerFactoryParam<PasswordGenerationPresenter, PasswordGenerationPresentationModel, dynamic>(
    (_model, _) => PasswordGenerationPresenter(_model, getIt(), getIt()),
  );
  getIt.registerFactory<PasswordGenerationNavigator>(
    () => PasswordGenerationNavigator(getIt()),
  );
  getIt.registerFactoryParam<SendMoneyPresenter, SendMoneyPresentationModel, dynamic>(
    (_model, _) => SendMoneyPresenter(_model, getIt(), getIt()),
  );
  getIt.registerFactory<SendMoneyNavigator>(
    () => SendMoneyNavigator(getIt()),
  );
  getIt.registerFactoryParam<RoutingPresenter, RoutingPresentationModel, dynamic>(
    (_model, _) => RoutingPresenter(_model, getIt(), getIt()),
  );
  getIt.registerFactory<RoutingNavigator>(
    () => RoutingNavigator(getIt()),
  );
  getIt.registerFactoryParam<MnemonicOnboardingPresenter, MnemonicOnboardingPresentationModel, dynamic>(
    (_model, _) => MnemonicOnboardingPresenter(_model, getIt(), getIt()),
  );
  getIt.registerFactory<MnemonicOnboardingNavigator>(
    () => MnemonicOnboardingNavigator(getIt()),
  );
}
