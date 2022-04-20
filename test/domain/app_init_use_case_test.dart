import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_app/domain/use_cases/migrate_app_versions_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late AppInitUseCase useCase;
  late MockAccountsRepository accountsRepository;
  late MockAccountsStore accountsStore;
  late MockSettingsStore settingsStore;
  late MockAuthRepository authRepository;
  late MockAppLocalizationsInitializer appLocalizationsInitializer;
  late MockGetChainsUseCase getChainsUseCase;
  late MockGetPricesUseCase getPricesUseCase;
  late MockGetVerifiedDenomsUseCase getVerifiedDenomsUseCase;
  late MigrateAppVersionsUseCase migrateAppVersionsUseCase;
  late MockGetBalancesUseCase getBalancesUseCase;
  late EmerisAccount realAccount;
  //
  test(
    'should initialize settings on start',
    () async {
      await useCase.execute();
      verify(() => settingsStore.init(authRepository));
    },
  );
  //
  test(
    'should NOT fetch balances if no accounts',
    () async {
      await useCase.execute();
      verifyNever(() => getBalancesUseCase.execute(details: any(named: 'details')));
    },
  );
  //
  test(
    'should fetch balances if has account',
    () async {
      when(() => accountsStore.currentAccount).thenReturn(realAccount);
      when(() => accountsStore.accounts).thenReturn(ObservableList.of([realAccount]));
      await useCase.execute();
      verify(() => getBalancesUseCase.execute(details: realAccount.accountDetails));
    },
  );
  //

  setUp(() {
    registerFallbackValue(const AccountDetails.empty());
    appLocalizationsInitializer = MockAppLocalizationsInitializer();
    accountsRepository = MockAccountsRepository();
    accountsStore = MockAccountsStore();
    settingsStore = MockSettingsStore();
    authRepository = MockAuthRepository();
    getPricesUseCase = MockGetPricesUseCase();
    getChainsUseCase = MockGetChainsUseCase();
    getVerifiedDenomsUseCase = MockGetVerifiedDenomsUseCase();
    migrateAppVersionsUseCase = MockMigrateAppVersionsUseCase();
    getBalancesUseCase = MockGetBalancesUseCase();
    useCase = AppInitUseCase(
      appLocalizationsInitializer,
      accountsRepository,
      accountsStore,
      settingsStore,
      authRepository,
      getPricesUseCase,
      getChainsUseCase,
      getVerifiedDenomsUseCase,
      migrateAppVersionsUseCase,
      getBalancesUseCase,
    );
    when(() => settingsStore.init(authRepository)) //
        .thenAnswer((invocation) => Future.value());
    when(() => accountsRepository.getAccountsList()) //
        .thenAnswer((invocation) => Future.value(right([])));
    when(() => accountsRepository.getCurrentAccount()) //
        .thenAnswer((invocation) => Future.value(right(const EmerisAccount.empty())));
    when(() => accountsRepository.setCurrentAccount(const AccountIdentifier.empty())) //
        .thenAnswer((invocation) => Future.value(right(const EmerisAccount.empty())));
    when(() => accountsStore.accounts) //
        .thenAnswer((invocation) => ObservableList());
    when(() => accountsStore.currentAccount) //
        .thenAnswer((invocation) => const EmerisAccount.empty());
    when(() => getPricesUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => getChainsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => getVerifiedDenomsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => migrateAppVersionsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => getBalancesUseCase.execute(details: any(named: 'details'))) //
        .thenAnswer((invocation) => successFuture(unit));
    realAccount = const EmerisAccount.empty().copyWith(
      accountDetails: const AccountDetails(
        accountIdentifier: AccountIdentifier(
          accountId: 'accountId',
          chainId: 'chainId',
        ),
        accountAlias: 'some name',
        accountAddress: AccountAddress(
          value: 'cosmos1l6qq7xwe5ge0xgryu493w37u9eg06kjc8jqde8',
        ),
      ),
    );
  });
}
