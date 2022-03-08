import 'package:flutter_app/ui/pages/add_account/add_account_initial_params.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';

class OnboardingPresenter {
  OnboardingPresenter(
    this._model,
    this.navigator,
  );

  final OnboardingPresentationModel _model;
  final OnboardingNavigator navigator;

  OnboardingViewModel get viewModel => _model;

  Future<void> onTapCreateAccount() async {
    final creationResult = await navigator.openAddAccount(const AddAccountInitialParams());
    if (creationResult != null) {
      await navigator.openRouting(const RoutingInitialParams());
    }
  }

  Future<void> onTapImportAccount() async {
    final result = await navigator.openImportAccount(const ImportAccountInitialParams());
    if (result != null) {
      await navigator.openRouting(const RoutingInitialParams());
    }
  }
}
