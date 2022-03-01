import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/change_current_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/delete_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_tokens_use_case.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:mocktail/mocktail.dart';

// Storages

class MockBiometricStorage extends Mock implements BiometricStorage {}

class MockBiometricStorageFile extends Mock implements BiometricStorageFile {}

// Initializers

class MockAppLocalizationsInitializer extends Mock implements AppLocalizationsInitializer {}

class MockAppInitializer extends Mock implements AppInitializer {}

// Repositories

class MockAuthRepository extends Mock implements AuthRepository {}

class MockWalletsRepository extends Mock implements WalletsRepository {}

class MockBlockchainMetadataRepository extends Mock implements BlockchainMetadataRepository {}

class MockChainsRepository extends Mock implements ChainsRepository {}

class MockBankRepository extends Mock implements BankRepository {}

// Stores

class MockWalletsStore extends Mock implements WalletsStore {}

class MockSettingsStore extends Mock implements SettingsStore {}

class MockBlockchainMetadataStore extends Mock implements BlockchainMetadataStore {}

// Use cases

class MockChangeCurrentWalletUseCase extends Mock implements ChangeCurrentWalletUseCase {}

class MockSendTokensUseCase extends Mock implements SendTokensUseCase {}

class MockGetBalancesUseCase extends Mock implements GetBalancesUseCase {}

class MockDeleteWalletUseCase extends Mock implements DeleteWalletUseCase {}

// Navigators

class MockSendTokensNavigator extends Mock implements SendTokensNavigator {}

class MockWalletDetailsNavigator extends Mock implements WalletDetailsNavigator {}

class MockWalletsListNavigator extends Mock implements WalletsListNavigator {}
