import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_page.dart';
import 'package:flutter_app/views/password_generation.dart';

class MnemonicOnboardingNavigator with NoRoutes, ErrorDialogRoute, PasswordGenerationRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  MnemonicOnboardingNavigator(this.appNavigator);
}

abstract class MnemonicOnboardingRoute {
  Future<void> openMnemonicOnboarding(MnemonicOnboardingInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(const MnemonicOnboardingPage(initialParams: MnemonicOnboardingInitialParams())),
      );

  AppNavigator get appNavigator;

  BuildContext get context;

  factory MnemonicOnboardingRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
