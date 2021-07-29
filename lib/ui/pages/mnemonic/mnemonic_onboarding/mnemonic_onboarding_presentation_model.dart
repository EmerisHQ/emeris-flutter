// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/model/failures/generate_mnemonic_failure.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class MnemonicOnboardingViewModel {
  String get mnemonic;

  List<String> get mnemonicWords;
}

class MnemonicOnboardingPresentationModel
    with MnemonicOnboardingPresentationModelBase
    implements MnemonicOnboardingViewModel {
  final MnemonicOnboardingInitialParams initialParams;

  MnemonicOnboardingPresentationModel(this.initialParams);

  @override
  String get mnemonic => _mnemonic.value;

  @override
  List<String> get mnemonicWords => mnemonic.trim().split(' ');

  ObservableFuture<Either<GenerateMnemonicFailure, String>>? get generateMnemonicFuture =>
      _generateMnemonicFuture.value;
}

//////////////////BOILERPLATE
abstract class MnemonicOnboardingPresentationModelBase {
  //////////////////////////////////////
  final Observable<String> _mnemonic = Observable("");

  set mnemonic(String value) => Action(() => _mnemonic.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<GenerateMnemonicFailure, String>>?> _generateMnemonicFuture =
      Observable(null);

  set generateMnemonicFuture(ObservableFuture<Either<GenerateMnemonicFailure, String>>? value) =>
      Action(() => _generateMnemonicFuture.value = value)();
}
