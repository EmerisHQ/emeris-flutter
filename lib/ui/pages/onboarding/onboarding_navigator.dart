import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_navigator.dart';

class OnboardingNavigator
    with ErrorDialogRoute, CloseRoute, RoutingRoute, WalletBackupIntroRoute, AddWalletRoute, ImportWalletRoute {
  @override
  OnboardingNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin OnboardingRoute {
  Future<void> openOnboarding(OnboardingInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(OnboardingPage(initialParams: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
