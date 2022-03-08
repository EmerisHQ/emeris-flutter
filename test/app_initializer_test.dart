import 'package:dartz/dartz.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import 'mocks/mocks.dart';

void main() {
  late AppInitializer initializer;
  late MockAccountsRepository accountsRepository;
  late MockAccountsStore accountsStore;
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
    accountsRepository = MockAccountsRepository();
    accountsStore = MockAccountsStore();
    settingsStore = MockSettingsStore();
    authRepository = MockAuthRepository();
    initializer = AppInitializer(
      appLocalizationsInitializer,
      accountsRepository,
      accountsStore,
      settingsStore,
      authRepository,
    );
    when(() => settingsStore.init(authRepository)) //
        .thenAnswer((invocation) => Future.value());
    when(() => accountsRepository.getAccountsList()) //
        .thenAnswer((invocation) => Future.value(right([])));
    when(() => accountsStore.accounts) //
        .thenAnswer((invocation) => ObservableList());
  });
}
