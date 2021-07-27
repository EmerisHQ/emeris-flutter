import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/ui/pages/mnemonic/mnemonic_onboarding/mnemonic_onboarding_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';

class RoutingNavigator with MnemonicOnboardingRoute, WalletsListRoute, CloseRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  RoutingNavigator(this.appNavigator);
}
