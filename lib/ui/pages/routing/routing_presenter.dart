import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter_app/domain/use_cases/change_current_wallet_use_case.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';
import 'package:flutter_app/utils/app_initializer.dart';
import 'package:flutter_app/utils/utils.dart';

class RoutingPresenter {
  RoutingPresenter(
    this._model,
    this.navigator,
    this._appInitializer,
    this._changeCurrentWalletUseCase,
  );

  final RoutingPresentationModel _model;
  final RoutingNavigator navigator;
  final AppInitializer _appInitializer;
  final ChangeCurrentWalletUseCase _changeCurrentWalletUseCase;

  RoutingViewModel get viewModel => _model;

  Future<void> init() async {
    if (_model.initializeApp) {
      await _appInitializer.init();
    }
    navigator.close();
    if (_model.wallets.isEmpty) {
      await navigator.openOnboarding(const OnboardingInitialParams());
    } else {
      await _changeCurrentWalletUseCase.execute(wallet: _model.wallets.first).observableDoOn(
            (fail) => navigator.showError(fail.displayableFailure()),
            (success) => doNothing(),
          );
      await navigator.openWalletDetails(_model.wallets.first);
    }
  }
}
