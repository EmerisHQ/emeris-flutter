import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/change_current_wallet_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_money_use_case.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:mocktail/mocktail.dart';

class BiometricStorageMock extends Mock implements BiometricStorage {}

class BiometricStorageFileMock extends Mock implements BiometricStorageFile {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockWalletsRepository extends Mock implements WalletsRepository {}

class MockWalletsStore extends Mock implements WalletsStore {}

class MockSettingsStore extends Mock implements SettingsStore {}

class MockAppLocalizationsInitializer extends Mock implements AppLocalizationsInitializer {}

class MockAppInitializer extends Mock implements AppInitializer {}

class MockChangeCurrentWalletUseCase extends Mock implements ChangeCurrentWalletUseCase {}

class MockSendMoneyUseCase extends Mock implements SendMoneyUseCase {}

class MockGetBalancesUseCase extends Mock implements GetBalancesUseCase {}

class BlockchainMetadataRepositoryMock extends Mock implements BlockchainMetadataRepository {}

class ChainsApiMock extends Mock implements ChainsRepository {}

class BankRepositoryMock extends Mock implements BankRepository {}

class MockSendMoneyNavigator extends Mock implements SendMoneyNavigator {}

class MockWalletDetailsNavigator extends Mock implements WalletDetailsNavigator {}
