import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';

class OnboardingNavigator with PasscodeRoute, WalletNameRoute, ErrorDialogRoute, CloseRoute, RoutingRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  OnboardingNavigator(this.appNavigator);
}

abstract class OnboardingRoute {
  Future<void> openOnboarding(OnboardingInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(OnboardingPage(initialParams: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;

  factory OnboardingRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
