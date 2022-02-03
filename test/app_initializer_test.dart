import 'package:dartz/dartz.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import 'mocks/mocks.dart';

void main() {
  late AppInitializer initializer;
  late MockWalletsRepository walletsRepository;
  late MockWalletsStore walletsStore;
  late MockSettingsStore settingsStore;
  late MockAuthRepository authRepository;
  late MockAppLocalizationsInitializer appLocalizationsInitializer;
  //
  test(
    'should initialize settings on start',
    () async {
      await initializer.init();
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
    initializer = AppInitializer(
      appLocalizationsInitializer,
      walletsRepository,
      walletsStore,
      settingsStore,
      authRepository,
    );
    when(() => settingsStore.init(authRepository)) //
        .thenAnswer((invocation) => Future.value());
    when(() => walletsRepository.getWalletsList()) //
        .thenAnswer((invocation) => Future.value(right([])));
    when(() => walletsStore.wallets) //
        .thenAnswer((invocation) => ObservableList());
  });
}
