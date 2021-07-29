import 'package:flutter_app/domain/use_cases/generate_mnemonic_use_case.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';

class MnemonicOnboardingPresenter {
  MnemonicOnboardingPresenter(
    this._model,
    this.navigator,
    this._generateMnemonicUseCase,
  );

  final MnemonicOnboardingPresentationModel _model;
  final MnemonicOnboardingNavigator navigator;
  final GenerateMnemonicUseCase _generateMnemonicUseCase;

  MnemonicOnboardingViewModel get viewModel => _model;

  void onProceedClicked() =>
      navigator.openPasswordGeneration(PasswordGenerationInitialParams(mnemonic: _model.mnemonic));

  void generateMnemonicClicked() {
    _model.generateMnemonicFuture = _generateMnemonicUseCase.execute().observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (newMnemonic) => _model.mnemonic = newMnemonic,
        );
  }
}
