// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';
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
abstract class OnboardingPresentationModelBase {}
