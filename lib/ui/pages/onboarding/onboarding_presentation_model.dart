// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

abstract class OnboardingViewModel {
  bool get isLoading;

  String get loadingMessage;
}

class OnboardingPresentationModel with OnboardingPresentationModelBase implements OnboardingViewModel {
  final OnboardingInitialParams initialParams;

  OnboardingPresentationModel(this.initialParams);

  ObservableFuture<Either<AddWalletFailure, Unit>>? get importWalletFuture => _importWalletFuture.value;

  @override
  bool get isLoading => isFutureInProgress(importWalletFuture) || isFutureInProgress(generateMnemonicFuture);

  ObservableFuture<String?>? get generateMnemonicFuture => _generateMnemonicFuture.value;

  @override
  String get loadingMessage {
    if (isFutureInProgress(importWalletFuture)) {
      return strings.importingWalletProgressMessage;
    } else if (isFutureInProgress(generateMnemonicFuture)) {
      return strings.generatingMnemonicProgressMessage;
    } else {
      return "";
    }
  }
}

//////////////////BOILERPLATE
abstract class OnboardingPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _importWalletFuture = Observable(null);

  set importWalletFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _importWalletFuture.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<String?>?> _generateMnemonicFuture = Observable(null);

  set generateMnemonicFuture(ObservableFuture<String?>? value) => Action(() => _generateMnemonicFuture.value = value)();
}
