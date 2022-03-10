import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late AppInitUseCase initializer;
  late MockAccountsRepository accountsRepository;
  late MockAccountsStore accountsStore;
  late MockSettingsStore settingsStore;
  late MockAuthRepository authRepository;
  late MockAppLocalizationsInitializer appLocalizationsInitializer;
  late MockGetChainsUseCase getChainsUseCase;
  late MockGetPricesUseCase getPricesUseCase;
  late MockGetVerifiedDenomsUseCase getVerifiedDenomsUseCase;
  //
  test(
    'should initialize settings on start',
    () async {
      await initializer.execute();
      verify(() => settingsStore.init(authRepository));
    },
  );
  //

  setUp(() {
    appLocalizationsInitializer = MockAppLocalizationsInitializer();
    accountsRepository = MockAccountsRepository();
    accountsStore = MockAccountsStore();
    settingsStore = MockSettingsStore();
    authRepository = MockAuthRepository();
    getPricesUseCase = MockGetPricesUseCase();
    getChainsUseCase = MockGetChainsUseCase();
    getVerifiedDenomsUseCase = MockGetVerifiedDenomsUseCase();
    initializer = AppInitUseCase(
      appLocalizationsInitializer,
      accountsRepository,
      accountsStore,
      settingsStore,
      authRepository,
      getPricesUseCase,
      getChainsUseCase,
      getVerifiedDenomsUseCase,
    );
    when(() => settingsStore.init(authRepository)) //
        .thenAnswer((invocation) => Future.value());
    when(() => accountsRepository.getAccountsList()) //
        .thenAnswer((invocation) => Future.value(right([])));
    when(() => accountsStore.accounts) //
        .thenAnswer((invocation) => ObservableList());
    when(() => getPricesUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => getChainsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
    when(() => getVerifiedDenomsUseCase.execute()) //
        .thenAnswer((invocation) => successFuture(unit));
  });
}
