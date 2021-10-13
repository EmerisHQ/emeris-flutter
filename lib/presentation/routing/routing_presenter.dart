import 'package:flutter_app/presentation/routing/routing_presentation_model.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/utils/app_initializer.dart';

class RoutingPresenter {
  RoutingPresenter(
    this._model,
    this.navigator,
    this._appInitializer,
  );

  final RoutingPresentationModel _model;
  final RoutingNavigator navigator;
  final AppInitializer _appInitializer;

  RoutingViewModel get viewModel => _model;

  Future<void> init() async {
    if (_model.initializeApp) {
      await _appInitializer.init();
    }
    navigator.close();
    // if (_model.wallets.isEmpty) {
    navigator.openOnboarding(const OnboardingInitialParams());
    // } else {
    //   navigator.openWalletsList(const WalletsListInitialParams());
    // }
  }
}
