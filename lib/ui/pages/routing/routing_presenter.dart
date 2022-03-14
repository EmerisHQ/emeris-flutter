import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter_app/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_app/domain/use_cases/change_current_account_use_case.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class RoutingPresenter {
  RoutingPresenter(
    this._model,
    this.navigator,
    this._appInitUseCase,
    this._changeCurrentAccountUseCase,
  );

  final RoutingPresentationModel _model;
  final RoutingNavigator navigator;
  final AppInitUseCase _appInitUseCase;
  final ChangeCurrentAccountUseCase _changeCurrentAccountUseCase;

  RoutingViewModel get viewModel => _model;

  Future<void> init() async {
    if (_model.initializeApp) {
      await _appInitUseCase.execute();
    }
    if (_model.accounts.isEmpty) {
      await navigator.openOnboarding(const OnboardingInitialParams());
    } else {
      await _changeCurrentAccountUseCase.execute(account: _model.accounts.first).observableDoOn(
            (fail) => navigator.showError(fail.displayableFailure()),
            (success) => doNothing(),
          );
      await navigator.openAccountDetails(replaceCurrent: true);
    }
  }
}
