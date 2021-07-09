import 'package:flutter_app/data/emeris/emeris_wallet_credentials_repository.dart';
import 'package:flutter_app/data/ethereum/ethereum_credentials_serializer.dart';
import 'package:flutter_app/data/ethereum/ethereum_wallet_handler.dart';
import 'package:flutter_app/data/sacco/sacco_credentials_serializer.dart';
import 'package:flutter_app/data/sacco/sacco_transaction_signer.dart';
import 'package:flutter_app/data/sacco/sacco_wallet_handler.dart';
import 'package:flutter_app/domain/repositories/wallet_credentials_repository.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_money_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/presentation/routing/routing_presentation_model.dart';
import 'package:flutter_app/presentation/routing/routing_presenter.dart';
import 'package:flutter_app/presentation/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/presentation/send_money/send_money_presenter.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presenter.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/transaction_summary_ui/mobile_transaction_summary_ui.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:get_it/get_it.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/key_info_storage.dart';
import 'package:transaction_signing_gateway/mobile/mobile_key_info_storage.dart';
import 'package:transaction_signing_gateway/transaction_summary_ui.dart';

final getIt = GetIt.instance;

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
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
    () => MobileKeyInfoStorage(serializers: [
      SaccoCredentialsSerializer(),
      EthereumCredentialsSerializer(),
    ]),
  );
  getIt.registerFactory<TransactionSigningGateway>(
    () => TransactionSigningGateway(
      transactionSummaryUI: getIt(),
      infoStorage: getIt(),
      signers: [
        SaccoTransactionSigner(),
      ],
    ),
  );
}

void _configureRepositories() {
  getIt.registerFactory<WalletCredentialsRepository>(
    () => EmerisWalletCredentialsRepository(getIt(), getIt()),
  );
}

void _configureStores() {
  getIt.registerLazySingleton<WalletsStore>(
    () => WalletsStore(),
  );
}

void _configureGeneralDependencies() {
  getIt.registerFactory<SaccoWalletHandler>(
    () => SaccoWalletHandler(getIt()),
  );
  getIt.registerFactory<EthereumWalletHandler>(
    () => EthereumWalletHandler(getIt()),
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
    () => GetBalancesUseCase(),
  );
  getIt.registerFactory<SendMoneyUseCase>(
    () => SendMoneyUseCase(),
  );
}

void _configureMvp() {
  getIt.registerFactoryParam<WalletsListPresenter, WalletsListPresentationModel, dynamic>(
    (_model, _) => WalletsListPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactory<WalletsListNavigator>(
    () => WalletsListNavigator(getIt()),
  );
  getIt.registerFactoryParam<WalletDetailsPresenter, WalletDetailsPresentationModel, dynamic>(
    (_model, _) => WalletDetailsPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactory<WalletDetailsNavigator>(
    () => WalletDetailsNavigator(getIt()),
  );
  getIt.registerFactoryParam<SendMoneyPresenter, SendMoneyPresentationModel, dynamic>(
    (_model, _) => SendMoneyPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactory<SendMoneyNavigator>(
    () => SendMoneyNavigator(getIt()),
  );
  getIt.registerFactoryParam<RoutingPresenter, RoutingPresentationModel, dynamic>(
    (_model, _) => RoutingPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactory<RoutingNavigator>(
    () => RoutingNavigator(getIt()),
  );
}
