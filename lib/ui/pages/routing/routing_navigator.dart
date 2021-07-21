import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emeris_app/navigation/app_navigator.dart';
import 'package:emeris_app/navigation/close_route.dart';
import 'package:emeris_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:emeris_app/views/mnemonic_onboarding.dart';

class RoutingNavigator with MnemonicOnboardingRoute, WalletsListRoute, CloseRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  RoutingNavigator(this.appNavigator);
}
