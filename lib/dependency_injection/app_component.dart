import 'package:cosmos_auth/cosmos_auth.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/api_calls/cosmos_wallet_api.dart';
import 'package:flutter_app/data/api_calls/ethereum_wallet_api.dart';
import 'package:flutter_app/data/api_calls/wallet_api.dart';
import 'package:flutter_app/data/blockchain/rest_api_blockchain_metadata_repository.dart';
import 'package:flutter_app/data/chains/rest_api_chains_repository.dart';
import 'package:flutter_app/data/cosmos/cosmos_auth_repository.dart';
import 'package:flutter_app/data/emeris/emeris_bank_repository.dart';
import 'package:flutter_app/data/emeris/emeris_transactions_repository.dart';
import 'package:flutter_app/data/emeris/emeris_wallets_repository.dart';
import 'package:flutter_app/data/ethereum/ethereum_credentials_serializer.dart';
import 'package:flutter_app/data/ethereum/ethereum_transaction_signer.dart';
import 'package:flutter_app/data/http/dio_builder.dart';
import 'package:flutter_app/data/http/http_service.dart';
import 'package:flutter_app/data/liquidity_pools/rest_api_liquidity_pools_repository.dart';
import 'package:flutter_app/data/web/web_key_info_storage.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/domain/repositories/liquidity_pools_repository.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/stores/platform_info_store.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/change_current_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/copy_to_clipboard_use_case.dart';
import 'package:flutter_app/domain/use_cases/delete_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/generate_mnemonic_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_chain_assets_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_prices_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_staked_amount_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/paste_from_clipboard_use_case.dart';
import 'package:flutter_app/domain/use_cases/save_passcode_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_tokens_use_case.dart';
import 'package:flutter_app/domain/use_cases/share_data_use_case.dart';
import 'package:flutter_app/domain/use_cases/verify_passcode_use_case.dart';
import 'package:flutter_app/domain/use_cases/verify_wallet_password_use_case.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_presenter.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_presenter.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presenter.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_presentation_model.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_presenter.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presenter.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presentation_model.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presenter.dart';
import 'package:flutter_app/ui/pages/receive/receive_navigator.dart';
import 'package:flutter_app/ui/pages/receive/receive_presentation_model.dart';
import 'package:flutter_app/ui/pages/receive/receive_presenter.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';
import 'package:flutter_app/ui/pages/routing/routing_presenter.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_page.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presenter.dart';
import 'package:flutter_app/ui/pages/transaction_summary_ui/mobile_transaction_summary_ui.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_presenter.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:flutter_app/utils/clipboard_manager.dart';
import 'package:flutter_app/utils/share_manager.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/transaction_summary_ui.dart';
import 'package:wallet_core/wallet_core.dart';

final getIt = GetIt.instance;

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies(EnvironmentConfig baseEnv) {
  getIt.registerSingleton<EnvironmentConfig>(baseEnv);
  _configureGeneralDependencies();
  _configureTransactionSigningGateway();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

void _configureTransactionSigningGateway() {
  getIt
    ..registerFactory<SecureDataStore>(FlutterSecureStorageDataStore.new)
    ..registerFactory<PlainDataStore>(SharedPrefsPlainDataStore.new)
    ..registerFactory<TransactionSummaryUI>(MobileTransactionSummaryUI.new)
    ..registerFactory<KeyInfoStorage>(
      () => kIsWeb
          ? WebKeyInfoStorage()
          : CosmosKeyInfoStorage(
              plainDataStore: getIt(),
              secureDataStore: getIt(),
              serializers: [
                AlanCredentialsSerializer(),
                EthereumCredentialsSerializer(),
              ],
            ),
    )
    ..registerFactory<TransactionSigningGateway>(
      () => TransactionSigningGateway(
        transactionSummaryUI: getIt(),
        infoStorage: getIt(),
        signers: [
          AlanTransactionSigner(getIt<EnvironmentConfig>().networkInfo),
          EthereumTransactionSigner(getIt()),
        ],
        broadcasters: [
          AlanTransactionBroadcaster(getIt<EnvironmentConfig>().networkInfo),
        ],
      ),
    );
}

void _configureRepositories() {
  getIt
    ..registerFactory<List<WalletApi>>(
      () => [
        CosmosWalletApi(getIt(), getIt()),
        EthereumWalletApi(getIt(), getIt()),
      ],
    )
    ..registerFactory<TransactionsRepository>(
      () => EmerisTransactionsRepository(getIt()),
    )
    ..registerFactory<WalletsRepository>(
      () => EmerisWalletsRepository(getIt(), getIt()),
    )
    ..registerFactory<BankRepository>(
      () => EmerisBankRepository(getIt()),
    )
    ..registerFactory<BlockchainMetadataRepository>(
      () => RestApiBlockchainMetadataRepository(getIt()),
    )
    ..registerFactory<AuthRepository>(
      () => CosmosAuthRepository(getIt(), getIt()),
    )
    ..registerFactory<LiquidityPoolsRepository>(
      () => RestApiLiquidityPoolsRepository(getIt()),
    )
    ..registerFactory<ChainsRepository>(
      () => RestApiChainsRepository(getIt()),
    );
}

void _configureStores() {
  getIt
    ..registerLazySingleton<WalletsStore>(
      WalletsStore.new,
    )
    ..registerLazySingleton<PlatformInfoStore>(
      PlatformInfoStore.new,
    )
    ..registerLazySingleton<SettingsStore>(
      SettingsStore.new,
    )
    ..registerLazySingleton<BlockchainMetadataStore>(
      BlockchainMetadataStore.new,
    );
}

void _configureGeneralDependencies() {
  getIt
    ..registerFactory<Web3Client>(
      () => Web3Client(getIt<EnvironmentConfig>().baseEthUrl, Client()),
    )
    ..registerFactory<DioBuilder>(
      () => DioBuilder(getIt()),
    )
    ..registerFactory<Dio>(
      () => getIt<DioBuilder>().build(),
    )
    ..registerFactory<AppNavigator>(
      AppNavigator.new,
    )
    ..registerFactory<AppLocalizationsInitializer>(
      () => AppLocalizationsInitializer(
        AppNavigator.navigatorKey.currentContext!,
      ),
    )
    ..registerFactory<AppInitializer>(
      () => AppInitializer(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<ClipboardManager>(
      ClipboardManager.new,
    )
    ..registerFactory<ShareManager>(
      ShareManager.new,
    )
    ..registerFactory<CosmosAuth>(
      CosmosAuth.new,
    )
    ..registerFactory<HttpService>(
      () => HttpService(getIt()),
    );
}

void _configureUseCases() {
  getIt
    ..registerFactory<ImportWalletUseCase>(
      () => ImportWalletUseCase(getIt(), getIt(), getIt()),
    )
    ..registerFactory<GetBalancesUseCase>(
      () => GetBalancesUseCase(getIt(), getIt(), getIt(), getIt()),
    )
    ..registerFactory<SendTokensUseCase>(
      () => SendTokensUseCase(getIt(), getIt()),
    )
    ..registerFactory<GenerateMnemonicUseCase>(
      GenerateMnemonicUseCase.new,
    )
    ..registerFactory<VerifyWalletPasswordUseCase>(
      () => VerifyWalletPasswordUseCase(getIt()),
    )
    ..registerFactory<ChangeCurrentWalletUseCase>(
      () => ChangeCurrentWalletUseCase(getIt()),
    )
    ..registerFactory<VerifyPasscodeUseCase>(
      () => VerifyPasscodeUseCase(getIt()),
    )
    ..registerFactory<SavePasscodeUseCase>(
      () => SavePasscodeUseCase(getIt(), getIt()),
    )
    ..registerFactory<GetStakedAmountUseCase>(
      () => GetStakedAmountUseCase(getIt()),
    )
    ..registerFactory<GetChainAssetsUseCase>(
      () => GetChainAssetsUseCase(getIt()),
    )
    ..registerFactory<CopyToClipboardUseCase>(
      () => CopyToClipboardUseCase(getIt()),
    )
    ..registerFactory<PasteFromClipboardUseCase>(
      () => PasteFromClipboardUseCase(getIt()),
    )
    ..registerFactory<ShareDataUseCase>(
      () => ShareDataUseCase(getIt()),
    )
    ..registerFactory<GetPricesUseCase>(
      () => GetPricesUseCase(getIt(), getIt()),
    )
    ..registerFactory<DeleteWalletUseCase>(
      () => DeleteWalletUseCase(getIt(), getIt(), getIt()),
    );
}

void _configureMvp() {
  getIt
    ..registerFactoryParam<WalletsListPresenter, WalletsListPresentationModel, dynamic>(
      (_model, _) => WalletsListPresenter(_model, getIt(), getIt(), getIt()),
    )
    ..registerFactory<WalletsListNavigator>(
      () => WalletsListNavigator(getIt()),
    )
    ..registerFactoryParam<WalletDetailsPresenter, WalletDetailsPresentationModel, dynamic>(
      (_model, _) => WalletDetailsPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<WalletDetailsNavigator>(
      () => WalletDetailsNavigator(getIt()),
    )
    ..registerFactoryParam<RoutingPresenter, RoutingPresentationModel, dynamic>(
      (_model, _) => RoutingPresenter(_model, getIt(), getIt(), getIt()),
    )
    ..registerFactory<RoutingNavigator>(
      () => RoutingNavigator(getIt()),
    )
    ..registerFactoryParam<OnboardingPresenter, OnboardingPresentationModel, dynamic>(
      (_model, _) => OnboardingPresenter(_model, getIt()),
    )
    ..registerFactory<OnboardingNavigator>(
      () => OnboardingNavigator(getIt()),
    )
    ..registerFactoryParam<WalletNamePresenter, WalletNamePresentationModel, dynamic>(
      (_model, _) => WalletNamePresenter(_model, getIt()),
    )
    ..registerFactory<WalletNameNavigator>(
      () => WalletNameNavigator(getIt()),
    )
    ..registerFactoryParam<PasscodePresenter, PasscodePresentationModel, dynamic>(
      (_model, _) => PasscodePresenter(_model, getIt(), getIt(), getIt()),
    )
    ..registerFactory<PasscodeNavigator>(
      () => PasscodeNavigator(getIt()),
    )
    ..registerFactoryParam<WalletBackupIntroPresenter, WalletBackupIntroPresentationModel, dynamic>(
      (_model, _) => WalletBackupIntroPresenter(_model, getIt()),
    )
    ..registerFactory<WalletBackupIntroNavigator>(
      () => WalletBackupIntroNavigator(getIt()),
    )
    ..registerFactoryParam<WalletCloudBackupPresenter, WalletCloudBackupPresentationModel, dynamic>(
      (_model, _) => WalletCloudBackupPresenter(_model, getIt()),
    )
    ..registerFactory<WalletCloudBackupNavigator>(
      () => WalletCloudBackupNavigator(getIt()),
    )
    ..registerFactoryParam<WalletManualBackupPresenter, WalletManualBackupPresentationModel, dynamic>(
      (_model, _) => WalletManualBackupPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<WalletManualBackupNavigator>(
      () => WalletManualBackupNavigator(getIt()),
    )
    ..registerFactoryParam<AddWalletPresenter, AddWalletPresentationModel, dynamic>(
      (_model, _) => AddWalletPresenter(
        _model,
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<AddWalletNavigator>(
      () => AddWalletNavigator(getIt()),
    )
    ..registerFactoryParam<ImportWalletPresenter, ImportWalletPresentationModel, dynamic>(
      (_model, _) => ImportWalletPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<ImportWalletNavigator>(
      () => ImportWalletNavigator(getIt()),
    )
    ..registerFactoryParam<MnemonicImportPresenter, MnemonicImportPresentationModel, dynamic>(
      (_model, _) => MnemonicImportPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<MnemonicImportNavigator>(
      () => MnemonicImportNavigator(getIt()),
    )
    ..registerFactoryParam<AssetDetailsPresenter, AssetDetailsPresentationModel, dynamic>(
      (_model, _) => AssetDetailsPresenter(_model, getIt(), getIt(), getIt()),
    )
    ..registerFactory<AssetDetailsNavigator>(
      () => AssetDetailsNavigator(getIt()),
    )
    ..registerFactoryParam<ReceivePresenter, ReceivePresentationModel, dynamic>(
      (_model, _) => ReceivePresenter(_model, getIt(), getIt(), getIt()),
    )
    ..registerFactory<ReceiveNavigator>(
      () => ReceiveNavigator(getIt()),
    )
    ..registerFactory<SendTokensNavigator>(
      () => SendTokensNavigator(getIt()),
    )
    ..registerFactoryParam<SendTokensPresentationModel, SendTokensInitialParams, dynamic>(
      (_params, _) => SendTokensPresentationModel(_params),
    )
    ..registerFactoryParam<SendTokensPresenter, SendTokensInitialParams, dynamic>(
      (initialParams, _) => SendTokensPresenter(
        getIt(param1: initialParams),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<SendTokensPage, SendTokensInitialParams, dynamic>(
      (initialParams, _) => SendTokensPage(
        presenter: getIt(param1: initialParams),
      ),
    );
}
