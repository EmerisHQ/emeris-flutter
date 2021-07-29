import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_page.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';

class PasswordGenerationNavigator with NoRoutes, WalletsListRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  PasswordGenerationNavigator(this.appNavigator);
}

abstract class PasswordGenerationRoute {
  Future<void> openPasswordGeneration(PasswordGenerationInitialParams initialParams) async =>
      appNavigator.push(context, materialRoute(PasswordGenerationPage(initialParams: initialParams)));

  AppNavigator get appNavigator;

  BuildContext get context;

  factory PasswordGenerationRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
