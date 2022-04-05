import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/settings/settings_initial_params.dart';
import 'package:flutter_app/ui/pages/settings/settings_page.dart';

class SettingsNavigator with CloseRoute<void>, ErrorDialogRoute {
  SettingsNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin SettingsRoute {
  Future<void> openSettings(SettingsInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(getIt<SettingsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
