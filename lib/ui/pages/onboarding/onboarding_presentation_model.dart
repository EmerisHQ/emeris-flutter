// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class OnboardingViewModel {}

class OnboardingPresentationModel with OnboardingPresentationModelBase implements OnboardingViewModel {
  final OnboardingInitialParams initialParams;

  OnboardingPresentationModel(this.initialParams);

  ObservableFuture<Either<AddWalletFailure, Unit>>? get importWalletFuture => _importWalletFuture.value;
}

//////////////////BOILERPLATE
abstract class OnboardingPresentationModelBase {
  //////////////////////////////////////
  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _importWalletFuture = Observable(null);

  set importWalletFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _importWalletFuture.value = value)();
}
