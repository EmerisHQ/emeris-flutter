import 'package:flutter_app/ui/pages/add_wallet/add_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_initial_params.dart';

class OnboardingPresenter {
  OnboardingPresenter(
    this._model,
    this.navigator,
  );

  final OnboardingPresentationModel _model;
  final OnboardingNavigator navigator;

  OnboardingViewModel get viewModel => _model;

  Future<void> onTapCreateWallet() async {
    final creationResult = await navigator.openAddWallet(const AddWalletInitialParams());
    if (creationResult != null) {
      navigator.close();
      await navigator.openRouting(const RoutingInitialParams());
    }
  }

  Future<void> onTapImportWallet() async {
    final result = await navigator.openImportWallet(const ImportWalletInitialParams());
    if (result != null) {
      navigator.close();
      await navigator.openRouting(const RoutingInitialParams());
    }
  }
}
