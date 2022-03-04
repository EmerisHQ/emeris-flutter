import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';
import 'package:flutter_app/ui/pages/routing/routing_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late RoutingInitialParams initParams;
  late RoutingPresentationModel model;
  late RoutingPresenter presenter;
  late RoutingNavigator navigator;
  late AppInitUseCase appInitializer;
  late MockWalletsStore walletsStore;
  late MockChangeCurrentWalletUseCase changeCurrentWalletUseCase;

  void _initMvp({
    bool initializeApp = false,
  }) {
    initParams = RoutingInitialParams(initializeApp: initializeApp);
    model = RoutingPresentationModel(initParams, walletsStore);
    navigator = MockRoutingNavigator();
    presenter = RoutingPresenter(
      model,
      navigator,
      appInitializer,
      changeCurrentWalletUseCase,
    );
    when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());
    when(() => navigator.openWalletDetails()).thenAnswer((_) => Future.value());
  }

  test(
    'initializing routing should call appInitializer if initializeApp is true',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      when(() => walletsStore.wallets).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => appInitializer.execute());
    },
  );

  test(
    'initializing routing should not call appInitializer if initializeApp is false',
    () async {
      // GIVEN
      _initMvp();
      when(() => walletsStore.wallets).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verifyNever(() => appInitializer.execute());
    },
  );

  test(
    'initializing routing should call appInitializer if initializeApp is true',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      when(() => walletsStore.wallets).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => appInitializer.execute());
    },
  );

  test(
    'no wallets should open onboardingPage',
    () async {
      // GIVEN
      _initMvp();
      when(() => walletsStore.wallets).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => navigator.openOnboarding(any()));
    },
  );

  setUp(() {
    registerFallbackValue(const OnboardingInitialParams());
    registerFallbackValue(const EmerisWallet.empty());
    appInitializer = MockAppInitializer();
    walletsStore = MockWalletsStore();
    changeCurrentWalletUseCase = MockChangeCurrentWalletUseCase();
    when(() => appInitializer.execute()).thenAnswer((invocation) => Future.value(right(unit)));
  });

  tearDown(() {});
}

class MockRoutingNavigator extends Mock implements RoutingNavigator {}
