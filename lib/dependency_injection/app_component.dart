import 'package:cosmos_auth/cosmos_auth.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/api_calls/account_api.dart';
import 'package:flutter_app/data/api_calls/cosmos_account_api.dart';
import 'package:flutter_app/data/api_calls/ethereum_account_api.dart';
import 'package:flutter_app/data/blockchain/rest_api_blockchain_metadata_repository.dart';
import 'package:flutter_app/data/chains/rest_api_chains_repository.dart';
import 'package:flutter_app/data/cosmos/cosmos_auth_repository.dart';
import 'package:flutter_app/data/emeris/emeris_accounts_repository.dart';
import 'package:flutter_app/data/emeris/emeris_bank_repository.dart';
import 'package:flutter_app/data/emeris/emeris_transactions_repository.dart';
import 'package:flutter_app/data/ethereum/ethereum_credentials_serializer.dart';
import 'package:flutter_app/data/ethereum/ethereum_transaction_signer.dart';
import 'package:flutter_app/data/http/dio_builder.dart';
import 'package:flutter_app/data/http/http_service.dart';
import 'package:flutter_app/data/liquidity_pools/rest_api_liquidity_pools_repository.dart';
import 'package:flutter_app/data/local/plain_store_local_storage.dart';
import 'package:flutter_app/data/web/web_key_info_storage.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/domain/repositories/liquidity_pools_repository.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/assets_store.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/stores/local_storage.dart';
import 'package:flutter_app/domain/stores/platform_info_store.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_app/domain/use_cases/change_current_account_use_case.dart';
import 'package:flutter_app/domain/use_cases/copy_to_clipboard_use_case.dart';
import 'package:flutter_app/domain/use_cases/delete_account_use_case.dart';
import 'package:flutter_app/domain/use_cases/delete_app_data_use_case.dart';
import 'package:flutter_app/domain/use_cases/generate_mnemonic_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_chains_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_prices_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_staked_amount_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_verified_denoms_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_account_use_case.dart';
import 'package:flutter_app/domain/use_cases/migrate_app_versions_use_case.dart';
import 'package:flutter_app/domain/use_cases/paste_from_clipboard_use_case.dart';
import 'package:flutter_app/domain/use_cases/rename_account_use_case.dart';
import 'package:flutter_app/domain/use_cases/save_passcode_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_tokens_use_case.dart';
import 'package:flutter_app/domain/use_cases/share_data_use_case.dart';
import 'package:flutter_app/domain/use_cases/verify_account_password_use_case.dart';
import 'package:flutter_app/domain/use_cases/verify_passcode_use_case.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_page.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_presenter.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_presenter.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presenter.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presenter.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presenter.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_presenter.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_presenter.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presenter.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_navigator.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_presenter.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presenter.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presenter.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presentation_model.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presenter.dart';
import 'package:flutter_app/ui/pages/receive/receive_navigator.dart';
import 'package:flutter_app/ui/pages/receive/receive_presentation_model.dart';
import 'package:flutter_app/ui/pages/receive/receive_presenter.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_initial_parameters.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_navigator.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_page.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presenter.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';
import 'package:flutter_app/ui/pages/routing/routing_presenter.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_initial_params.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_navigator.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_page.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_presentation_model.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_presenter.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_page.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_presenter.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_page.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presenter.dart';
import 'package:flutter_app/ui/pages/settings/settings_initial_params.dart';
import 'package:flutter_app/ui/pages/settings/settings_navigator.dart';
import 'package:flutter_app/ui/pages/settings/settings_page.dart';
import 'package:flutter_app/ui/pages/settings/settings_presentation_model.dart';
import 'package:flutter_app/ui/pages/settings/settings_presenter.dart';
import 'package:flutter_app/ui/pages/transaction_summary_ui/mobile_transaction_summary_ui.dart';
import 'package:flutter_app/utils/clipboard_manager.dart';
import 'package:flutter_app/utils/price_converter.dart';
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
    ..registerFactory<List<AccountApi>>(
      () => [
        CosmosAccountApi(getIt(), getIt()),
        EthereumAccountApi(getIt(), getIt()),
      ],
    )
    ..registerFactory<TransactionsRepository>(
      () => EmerisTransactionsRepository(getIt()),
    )
    ..registerFactory<AccountsRepository>(
      () => EmerisAccountsRepository(getIt(), getIt()),
    )
    ..registerFactory<BankRepository>(
      () => EmerisBankRepository(getIt(), getIt()),
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
    ..registerLazySingleton<AccountsStore>(
      AccountsStore.new,
    )
    ..registerLazySingleton<PlatformInfoStore>(
      PlatformInfoStore.new,
    )
    ..registerLazySingleton<SettingsStore>(
      SettingsStore.new,
    )
    ..registerLazySingleton<BlockchainMetadataStore>(
      BlockchainMetadataStore.new,
    )
    ..registerLazySingleton<AssetsStore>(
      AssetsStore.new,
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
    )
    ..registerFactory<PriceConverter>(
      PriceConverter.new,
    )
    ..registerFactory<LocalStorage>(
      () => PlainStoreLocalStorage(getIt()),
    )
    ..registerFactory<AppInfoProvider>(AppInfoProvider.new);
}

void _configureUseCases() {
  getIt
    ..registerFactory<ImportAccountUseCase>(
      () => ImportAccountUseCase(getIt(), getIt(), getIt()),
    )
    ..registerFactory<GetBalancesUseCase>(
      () => GetBalancesUseCase(getIt(), getIt(), getIt(), getIt(), getIt()),
    )
    ..registerFactory<SendTokensUseCase>(
      () => SendTokensUseCase(getIt(), getIt()),
    )
    ..registerFactory<GenerateMnemonicUseCase>(
      GenerateMnemonicUseCase.new,
    )
    ..registerFactory<VerifyAccountPasswordUseCase>(
      () => VerifyAccountPasswordUseCase(getIt()),
    )
    ..registerFactory<ChangeCurrentAccountUseCase>(
      () => ChangeCurrentAccountUseCase(getIt(), getIt(), getIt()),
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
    ..registerFactory<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(getIt(), getIt(), getIt()),
    )
    ..registerFactory<AppInitUseCase>(
      () => AppInitUseCase(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<GetChainsUseCase>(
      () => GetChainsUseCase(getIt(), getIt()),
    )
    ..registerFactory<GetVerifiedDenomsUseCase>(
      () => GetVerifiedDenomsUseCase(getIt(), getIt()),
    )
    ..registerFactory<RenameAccountUseCase>(
      () => RenameAccountUseCase(getIt(), getIt()),
    )
    ..registerFactory<DeleteAppDataUseCase>(
      () => DeleteAppDataUseCase(getIt()),
    )
    ..registerFactory<List<MigrationStep>>(
      () => [],
    )
    ..registerFactory<MigrateAppVersionsUseCase>(
      () => MigrateAppVersionsUseCase(getIt(), getIt(), getIt()),
    );
}

void _configureMvp() {
  getIt
    ..registerFactoryParam<AccountsListPresenter, AccountsListPresentationModel, dynamic>(
      (_model, _) => AccountsListPresenter(_model, getIt(), getIt(), getIt()),
    )
    ..registerFactory<AccountsListNavigator>(
      () => AccountsListNavigator(getIt()),
    )
    ..registerFactoryParam<AccountDetailsPresenter, AccountDetailsPresentationModel, dynamic>(
      (_model, _) => AccountDetailsPresenter(_model, getIt()),
    )
    ..registerFactory<AccountDetailsNavigator>(
      () => AccountDetailsNavigator(getIt()),
    )
    ..registerFactoryParam<RoutingPresenter, RoutingPresentationModel, dynamic>(
      (_model, _) => RoutingPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<RoutingNavigator>(
      () => RoutingNavigator(getIt()),
    )
    ..registerFactoryParam<AccountNamePresenter, AccountNamePresentationModel, dynamic>(
      (_model, _) => AccountNamePresenter(_model, getIt()),
    )
    ..registerFactory<AccountNameNavigator>(
      () => AccountNameNavigator(getIt()),
    )
    ..registerFactoryParam<PasscodePresenter, PasscodePresentationModel, dynamic>(
      (_model, _) => PasscodePresenter(_model, getIt(), getIt(), getIt()),
    )
    ..registerFactory<PasscodeNavigator>(
      () => PasscodeNavigator(getIt()),
    )
    ..registerFactoryParam<AccountCloudBackupPresenter, AccountCloudBackupPresentationModel, dynamic>(
      (_model, _) => AccountCloudBackupPresenter(_model, getIt()),
    )
    ..registerFactory<AccountCloudBackupNavigator>(
      () => AccountCloudBackupNavigator(getIt()),
    )
    ..registerFactoryParam<AccountManualBackupPresenter, AccountManualBackupPresentationModel, dynamic>(
      (_model, _) => AccountManualBackupPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<AccountManualBackupNavigator>(
      () => AccountManualBackupNavigator(getIt()),
    )
    ..registerFactoryParam<AddAccountPresenter, AddAccountPresentationModel, dynamic>(
      (_model, _) => AddAccountPresenter(
        _model,
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<AddAccountNavigator>(
      () => AddAccountNavigator(getIt()),
    )
    ..registerFactoryParam<ImportAccountPresenter, ImportAccountPresentationModel, dynamic>(
      (_model, _) => ImportAccountPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<ImportAccountNavigator>(
      () => ImportAccountNavigator(getIt()),
    )
    ..registerFactoryParam<MnemonicImportPresenter, MnemonicImportPresentationModel, dynamic>(
      (_model, _) => MnemonicImportPresenter(_model, getIt(), getIt()),
    )
    ..registerFactory<MnemonicImportNavigator>(
      () => MnemonicImportNavigator(getIt()),
    )
    ..registerFactoryParam<AssetDetailsPresenter, AssetDetailsPresentationModel, dynamic>(
      (_model, _) => AssetDetailsPresenter(_model, getIt(), getIt()),
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
      (_params, _) => SendTokensPresentationModel(
        _params,
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<SendTokensPresenter, SendTokensInitialParams, dynamic>(
      (initialParams, _) => SendTokensPresenter(
        getIt(param1: initialParams),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<SendTokensPage, SendTokensInitialParams, dynamic>(
      (initialParams, _) => SendTokensPage(
        presenter: getIt(param1: initialParams),
      ),
    )
    ..registerFactoryParam<RenameAccountPresentationModel, RenameAccountInitialParams, dynamic>(
      (_params, _) => RenameAccountPresentationModel(_params),
    )
    ..registerFactoryParam<RenameAccountPresenter, RenameAccountInitialParams, dynamic>(
      (params, _) => RenameAccountPresenter(
        getIt(param1: params),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<RenameAccountNavigator>(
      () => RenameAccountNavigator(getIt()),
    )
    ..registerFactoryParam<RenameAccountPage, RenameAccountInitialParams, dynamic>(
      (initialParams, _) => RenameAccountPage(
        presenter: getIt(param1: initialParams),
      ),
    )
    ..registerFactory<BalanceSelectorNavigator>(
      () {
        return BalanceSelectorNavigator(getIt());
      },
    )
    ..registerFactoryParam<BalanceSelectorPresentationModel, BalanceSelectorInitialParams, dynamic>(
      (_params, _) => BalanceSelectorPresentationModel(getIt(), getIt(), _params),
    )
    ..registerFactoryParam<BalanceSelectorPresenter, BalanceSelectorInitialParams, dynamic>(
      (initialParams, _) {
        return BalanceSelectorPresenter(
          getIt(param1: initialParams),
          getIt(),
        );
      },
    )
    ..registerFactoryParam<BalanceSelectorPage, BalanceSelectorInitialParams, dynamic>(
      (initialParams, _) {
        return BalanceSelectorPage(
          presenter: getIt(param1: initialParams),
        );
      },
    )
    ..registerFactoryParam<SettingsPresentationModel, SettingsInitialParams, dynamic>(
      (_params, _) => SettingsPresentationModel(_params),
    )
    ..registerFactoryParam<SettingsPresenter, SettingsInitialParams, dynamic>(
      (params, _) => SettingsPresenter(
        getIt(param1: params),
        getIt(),
      ),
    )
    ..registerFactory<SettingsNavigator>(
      () => SettingsNavigator(getIt()),
    )
    ..registerFactoryParam<SettingsPage, SettingsInitialParams, dynamic>(
      (initialParams, _) => SettingsPage(
        presenter: getIt(param1: initialParams),
      ),
    )
    ..registerFactoryParam<ScanQrPresentationModel, ScanQrInitialParams, dynamic>(
      (_params, _) => ScanQrPresentationModel(_params, getIt()),
    )
    ..registerFactoryParam<ScanQrPresenter, ScanQrInitialParams, dynamic>(
      (params, _) => ScanQrPresenter(
        getIt(param1: params),
        getIt(),
      ),
    )
    ..registerFactory<ScanQrNavigator>(
      () => ScanQrNavigator(getIt()),
    )
    ..registerFactoryParam<ScanQrPage, ScanQrInitialParams, dynamic>(
      (initialParams, _) => ScanQrPage(
        presenter: getIt(param1: initialParams),
      ),
    )
    ..registerFactoryParam<OnboardingPresentationModel, OnboardingInitialParams, dynamic>(
      (_params, _) => OnboardingPresentationModel(_params),
    )
    ..registerFactoryParam<OnboardingPresenter, OnboardingInitialParams, dynamic>(
      (params, _) => OnboardingPresenter(
        getIt(param1: params),
        getIt(),
      ),
    )
    ..registerFactory<OnboardingNavigator>(
      () => OnboardingNavigator(getIt()),
    )
    ..registerFactoryParam<OnboardingPage, OnboardingInitialParams, dynamic>(
      (initialParams, _) => OnboardingPage(
        presenter: getIt(param1: initialParams),
      ),
    )
    ..registerFactoryParam<AccountBackupIntroPresentationModel, AccountBackupIntroInitialParams, dynamic>(
      (_params, _) => AccountBackupIntroPresentationModel(_params, getIt()),
    )
    ..registerFactoryParam<AccountBackupIntroPresenter, AccountBackupIntroInitialParams, dynamic>(
      (params, _) => AccountBackupIntroPresenter(
        getIt(param1: params),
        getIt(),
      ),
    )
    ..registerFactory<AccountBackupIntroNavigator>(
      () => AccountBackupIntroNavigator(getIt()),
    )
    ..registerFactoryParam<AccountBackupIntroPage, AccountBackupIntroInitialParams, dynamic>(
      (initialParams, _) => AccountBackupIntroPage(
        presenter: getIt(param1: initialParams),
      ),
    );
}
