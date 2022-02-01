// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';

abstract class OnboardingViewModel {}

class OnboardingPresentationModel with OnboardingPresentationModelBase implements OnboardingViewModel {
  OnboardingPresentationModel(this.initialParams);

  final OnboardingInitialParams initialParams;
}

//////////////////BOILERPLATE
mixin OnboardingPresentationModelBase {}
