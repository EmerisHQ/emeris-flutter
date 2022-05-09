import 'package:dartz/dartz.dart';
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

  void _initMvp({
    bool initializeApp = false,
  }) {
    initParams = RoutingInitialParams(initializeApp: initializeApp);
    model = RoutingPresentationModel(initParams, Mocks.accountsStore);
    navigator = Mocks.routingNavigator;
    presenter = RoutingPresenter(
      model,
      navigator,
      Mocks.appInitializer,
    );
    when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());
    when(() => navigator.openAccountDetails()).thenAnswer((_) => Future.value());
  }

  test(
    'initializing routing should call appInitializer if initializeApp is true',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      when(() => Mocks.accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => Mocks.appInitializer.execute());
    },
  );

  test(
    'initializing routing should not call appInitializer if initializeApp is false',
    () async {
      // GIVEN
      _initMvp();
      when(() => Mocks.accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verifyNever(() => Mocks.appInitializer.execute());
    },
  );

  test(
    'initializing routing should call appInitializer if initializeApp is true',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      when(() => Mocks.accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => Mocks.appInitializer.execute());
    },
  );

  test(
    'no accounts should open onboardingPage',
    () async {
      // GIVEN
      _initMvp();
      when(() => Mocks.accountsStore.accounts).thenReturn(ObservableList());
      // WHEN
      await presenter.init();
      //THEN
      verify(() => navigator.openOnboarding(any()));
    },
  );

  setUp(() {
    when(() => Mocks.appInitializer.execute()).thenAnswer((invocation) => Future.value(right(unit)));
  });
}
