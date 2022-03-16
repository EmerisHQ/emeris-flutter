import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/assets_store.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_app/domain/use_cases/change_current_account_use_case.dart';
import 'package:flutter_app/domain/use_cases/delete_account_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_chains_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_prices_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_verified_denoms_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_tokens_use_case.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:mocktail/mocktail.dart';

// Storages

class MockBiometricStorage extends Mock implements BiometricStorage {}

class MockBiometricStorageFile extends Mock implements BiometricStorageFile {}

// Initializers

class MockAppLocalizationsInitializer extends Mock implements AppLocalizationsInitializer {}

class MockAppInitializer extends Mock implements AppInitUseCase {}

// Repositories

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAccountsRepository extends Mock implements AccountsRepository {}

class MockBlockchainMetadataRepository extends Mock implements BlockchainMetadataRepository {}

class MockChainsRepository extends Mock implements ChainsRepository {}

class MockBankRepository extends Mock implements BankRepository {}

// Stores

class MockAccountsStore extends Mock implements AccountsStore {}

class MockSettingsStore extends Mock implements SettingsStore {}

class MockBlockchainMetadataStore extends Mock implements BlockchainMetadataStore {}

class MockAssetsStore extends Mock implements AssetsStore {}

// Use cases

class MockChangeCurrentAccountUseCase extends Mock implements ChangeCurrentAccountUseCase {}

class MockSendTokensUseCase extends Mock implements SendTokensUseCase {}

class MockGetBalancesUseCase extends Mock implements GetBalancesUseCase {}

class MockDeleteAccountUseCase extends Mock implements DeleteAccountUseCase {}

class MockGetPricesUseCase extends Mock implements GetPricesUseCase {}

class MockGetChainsUseCase extends Mock implements GetChainsUseCase {}

class MockGetVerifiedDenomsUseCase extends Mock implements GetVerifiedDenomsUseCase {}
// Navigators

class MockSendTokensNavigator extends Mock implements SendTokensNavigator {}

class MockAccountDetailsNavigator extends Mock implements AccountDetailsNavigator {}

class MockAccountsListNavigator extends Mock implements AccountsListNavigator {}
