import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/presentation/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/onboarding/onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_page.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';

class RoutingNavigator with OnboardingRoute, WalletsListRoute, CloseRoute, WalletDetailsRoute, ErrorDialogRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  RoutingNavigator(this.appNavigator);
}

abstract class RoutingRoute {
  Future<void> openRouting(RoutingInitialParams initialParams, {bool popUntilRoot = true}) async {
    if (popUntilRoot) {
      appNavigator.popUntilRoot(context);
    }
    return appNavigator.push(
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

  factory RoutingRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
