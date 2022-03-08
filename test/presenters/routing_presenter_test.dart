import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';
import 'package:flutter_app/ui/pages/routing/routing_presenter.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late RoutingInitialParams initParams;
  late RoutingPresentationModel model;
  late RoutingPresenter presenter;
  late RoutingNavigator navigator;
  late AppInitializer appInitializer;
  late MockAccountsStore accountsStore;
  late MockChangeCurrentAccountUseCase changeCurrentAccountUseCase;

  void _initMvp({
    bool initializeApp = false,
  }) {
    initParams = RoutingInitialParams(initializeApp: initializeApp);
    model = RoutingPresentationModel(initParams, accountsStore);
    navigator = MockRoutingNavigator();
    presenter = RoutingPresenter(
      model,
      navigator,
      appInitializer,
      changeCurrentAccountUseCase,
    );
    when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());
    when(() => navigator.openAccountDetails()).thenAnswer((_) => Future.value());
  }

  test(
    'initializing routing should call appInitializer if initializeApp is true',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      when(() => accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => appInitializer.init());
    },
  );

  test(
    'initializing routing should not call appInitializer if initializeApp is false',
    () async {
      // GIVEN
      _initMvp();
      when(() => accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verifyNever(() => appInitializer.init());
    },
  );

  test(
    'initializing routing should call appInitializer if initializeApp is true',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      when(() => accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => appInitializer.init());
    },
  );

  test(
    'no accounts should open onboardingPage',
    () async {
      // GIVEN
      _initMvp();
      when(() => accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => navigator.openOnboarding(any()));
    },
  );

  setUp(() {
    registerFallbackValue(const OnboardingInitialParams());
    registerFallbackValue(const EmerisAccount.empty());
    appInitializer = MockAppInitializer();
    accountsStore = MockAccountsStore();
    changeCurrentAccountUseCase = MockChangeCurrentAccountUseCase();
    when(() => appInitializer.init()).thenAnswer((invocation) => Future.value());
  });

  tearDown(() {});
}

class MockRoutingNavigator extends Mock implements RoutingNavigator {}
