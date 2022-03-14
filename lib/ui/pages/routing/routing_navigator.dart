import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_page.dart';

class RoutingNavigator with OnboardingRoute, AccountsListRoute, CloseRoute, AccountDetailsRoute, ErrorDialogRoute {
  RoutingNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin RoutingRoute {
  Future<void> openRouting(RoutingInitialParams initialParams, {bool popUntilRoot = true}) async {
    if (popUntilRoot) {
      appNavigator.popUntilRoot(context);
    }
    return appNavigator.pushReplacement(
      context,
      materialRoute(
        const RoutingPage(
          initialParams: RoutingInitialParams(),
        ),
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
