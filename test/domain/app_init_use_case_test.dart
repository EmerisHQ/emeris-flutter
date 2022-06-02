import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late AppInitUseCase useCase;
  late EmerisAccount realAccount;
  //
  test(
    'should initialize settings on start',
    () async {
      await useCase.execute();
      verify(() => Mocks.settingsStore.init(Mocks.authRepository));
    },
  );
  //
  test(
    'should NOT fetch balances if no accounts',
    () async {
      await useCase.execute();
      verifyNever(() => Mocks.getBalancesUseCase.execute(details: any(named: 'details')));
    },
  );
  //
  test(
    'should fetch balances if has account',
    () async {
      when(() => Mocks.accountsStore.currentAccount).thenReturn(realAccount);
      when(() => Mocks.accountsStore.accounts).thenReturn(ObservableList.of([realAccount]));
      await useCase.execute();
      verify(() => Mocks.getBalancesUseCase.execute(details: realAccount.accountDetails));
    },
  );
  //

  setUp(() {
    useCase = AppInitUseCase(
      Mocks.appLocalizationsInitializer,
      Mocks.accountsRepository,
      Mocks.accountsStore,
      Mocks.settingsStore,
      Mocks.authRepository,
      Mocks.getPricesUseCase,
      Mocks.getChainsUseCase,
      Mocks.getVerifiedDenomsUseCase,
      Mocks.migrateAppVersionsUseCase,
      Mocks.getBalancesUseCase,
    );
    when(() => Mocks.settingsStore.init(Mocks.authRepository)) //
        .thenAnswer((invocation) => Future.value());
    when(() => Mocks.accountsRepository.getAccountsList()) //
        .thenAnswer((invocation) => Future.value(right([])));
    when(() => Mocks.accountsRepository.getCurrentAccount()) //
        .thenAnswer((invocation) => Future.value(right(const EmerisAccount.empty())));
    when(() => Mocks.accountsRepository.setCurrentAccount(const AccountIdentifier.empty())) //
        .thenAnswer((invocation) => Future.value(right(const EmerisAccount.empty())));
    when(() => Mocks.accountsStore.accounts) //
        .thenAnswer((invocation) => ObservableList());
    when(() => Mocks.accountsStore.currentAccount) //
        .thenAnswer((invocation) => const EmerisAccount.empty());
    when(() => Mocks.getPricesUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => Mocks.getChainsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => Mocks.getVerifiedDenomsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => Mocks.migrateAppVersionsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => Mocks.getBalancesUseCase.execute(details: any(named: 'details'))) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => Mocks.updateThemeUseCase.execute(isDarkTheme: any(named: 'isDarkTheme'))) //
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
