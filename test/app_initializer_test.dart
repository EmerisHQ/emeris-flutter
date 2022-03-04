import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import 'mocks/mocks.dart';

void main() {
  late AppInitUseCase initializer;
  late MockWalletsRepository walletsRepository;
  late MockWalletsStore walletsStore;
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
    walletsRepository = MockWalletsRepository();
    walletsStore = MockWalletsStore();
    settingsStore = MockSettingsStore();
    authRepository = MockAuthRepository();
    getPricesUseCase = MockGetPricesUseCase();
    getChainsUseCase = MockGetChainsUseCase();
    getVerifiedDenomsUseCase = MockGetVerifiedDenomsUseCase();
    initializer = AppInitUseCase(
      appLocalizationsInitializer,
      walletsRepository,
      walletsStore,
      settingsStore,
      authRepository,
      getPricesUseCase,
      getChainsUseCase,
      getVerifiedDenomsUseCase,
    );
    when(() => settingsStore.init(authRepository)) //
        .thenAnswer((invocation) => Future.value());
    when(() => walletsRepository.getWalletsList()) //
        .thenAnswer((invocation) => Future.value(right([])));
    when(() => walletsStore.wallets) //
        .thenAnswer((invocation) => ObservableList());
  });
}
