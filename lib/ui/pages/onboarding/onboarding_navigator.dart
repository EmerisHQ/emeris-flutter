import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_navigator.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';

class OnboardingNavigator
    with ErrorDialogRoute, CloseRoute, RoutingRoute, AccountBackupIntroRoute, AddAccountRoute, ImportAccountRoute {
  @override
  OnboardingNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin OnboardingRoute {
  Future<void> openOnboarding(OnboardingInitialParams initialParams) async => appNavigator.pushReplacement(
        context,
        fadeInRoute(OnboardingPage(initialParams: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
