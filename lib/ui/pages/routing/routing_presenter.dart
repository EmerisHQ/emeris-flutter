import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';

class RoutingPresenter {
  RoutingPresenter(
    this._model,
    this.navigator,
    this._appInitUseCase,
  );

  final RoutingPresentationModel _model;
  final RoutingNavigator navigator;
  final AppInitUseCase _appInitUseCase;

  RoutingViewModel get viewModel => _model;

  Future<void> init() async {
    if (_model.initializeApp) {
      await _appInitUseCase.execute();
    }
    if (_model.accounts.isEmpty) {
      await navigator.openOnboarding(const OnboardingInitialParams());
    } else {
      await navigator.openAccountDetails(replaceCurrent: true);
    }
  }
}
