import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_initial_params.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks_definitions.dart';

// ignore: avoid_classes_with_only_static_members
class Mocks {
  static late MockBiometricStorage biometricStorage;
  static late MockBiometricStorageFile biometricStorageFile;
  static late MockAppLocalizationsInitializer appLocalizationsInitializer;
  static late MockAppInitializer appInitializer;
  static late MockAuthRepository authRepository;
  static late MockAccountsRepository accountsRepository;
  static late MockBlockchainMetadataRepository blockchainMetadataRepository;
  static late MockChainsRepository chainsRepository;
  static late MockBankRepository bankRepository;
  static late MockAccountsStore accountsStore;
  static late MockSettingsStore settingsStore;
  static late MockBlockchainMetadataStore blockchainMetadataStore;
  static late MockAssetsStore assetsStore;
  static late MockPlatformInfoStore platformInfoStore;
  static late MockChangeCurrentAccountUseCase changeCurrentAccountUseCase;
  static late MockSendTokensUseCase sendTokensUseCase;
  static late MockGetBalancesUseCase getBalancesUseCase;
  static late MockDeleteAccountUseCase deleteAccountUseCase;
  static late MockGetPricesUseCase getPricesUseCase;
  static late MockGetChainsUseCase getChainsUseCase;
  static late MockGetVerifiedDenomsUseCase getVerifiedDenomsUseCase;
  static late MockMigrateAppVersionsUseCase migrateAppVersionsUseCase;
  static late MockCopyToClipboardUseCase copyToClipboardUseCase;
  static late MockUpdateThemeUseCase updateThemeUseCase;
  static late MockRenameAccountUseCase renameAccountUseCase;
  static late MockImportAccountUseCase importAccountUseCase;
  static late MockPasteFromClipboardUseCase pasteFromClipboardUseCase;
  static late MockSendTokensNavigator sendTokensNavigator;
  static late MockAccountDetailsNavigator accountDetailsNavigator;
  static late MockAccountsListNavigator accountsListNavigator;
  static late MockAppNavigator appNavigator;
  static late MockRoutingNavigator routingNavigator;
  static late MockTaskScheduler taskScheduler;
  static late MockPriceConverter priceConverter;
  static late MockGenerateMnemonicUseCase generateMnemonicUseCase;

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    biometricStorage = MockBiometricStorage();
    biometricStorageFile = MockBiometricStorageFile();
    appLocalizationsInitializer = MockAppLocalizationsInitializer();
    appInitializer = MockAppInitializer();
    authRepository = MockAuthRepository();
    accountsRepository = MockAccountsRepository();
    blockchainMetadataRepository = MockBlockchainMetadataRepository();
    chainsRepository = MockChainsRepository();
    bankRepository = MockBankRepository();
    accountsStore = MockAccountsStore();
    settingsStore = MockSettingsStore();
    blockchainMetadataStore = MockBlockchainMetadataStore();
    assetsStore = MockAssetsStore();
    changeCurrentAccountUseCase = MockChangeCurrentAccountUseCase();
    sendTokensUseCase = MockSendTokensUseCase();
    getBalancesUseCase = MockGetBalancesUseCase();
    deleteAccountUseCase = MockDeleteAccountUseCase();
    getPricesUseCase = MockGetPricesUseCase();
    getChainsUseCase = MockGetChainsUseCase();
    getVerifiedDenomsUseCase = MockGetVerifiedDenomsUseCase();
    migrateAppVersionsUseCase = MockMigrateAppVersionsUseCase();
    copyToClipboardUseCase = MockCopyToClipboardUseCase();
    importAccountUseCase = MockImportAccountUseCase();
    generateMnemonicUseCase = MockGenerateMnemonicUseCase();
    updateThemeUseCase = MockUpdateThemeUseCase();
    renameAccountUseCase = MockRenameAccountUseCase();
    pasteFromClipboardUseCase = MockPasteFromClipboardUseCase();
    sendTokensNavigator = MockSendTokensNavigator();
    accountDetailsNavigator = MockAccountDetailsNavigator();
    accountsListNavigator = MockAccountsListNavigator();
    appNavigator = MockAppNavigator();
    routingNavigator = MockRoutingNavigator();
    platformInfoStore = MockPlatformInfoStore();
    taskScheduler = MockTaskScheduler();
    priceConverter = MockPriceConverter();
  }

  static void _initFallbacks() {
    registerFallbackValue(Brightness.dark);
    registerFallbackValue(ChainAsset.empty());
    registerFallbackValue(const Prices.empty());
    registerFallbackValue(const EmerisAccount.empty());
    registerFallbackValue(const AccountIdentifier.empty());
    registerFallbackValue(const AccountDetails.empty());
    registerFallbackValue(const OnboardingInitialParams());
    registerFallbackValue(const AddAccountInitialParams());
    registerFallbackValue(const ImportAccountInitialParams());
    registerFallbackValue(const RoutingInitialParams());
    registerFallbackValue(Duration.zero);
  }
}
