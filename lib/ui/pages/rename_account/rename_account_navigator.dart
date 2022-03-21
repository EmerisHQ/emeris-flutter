import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_initial_parameters.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_page.dart';

class RenameAccountNavigator with CloseRoute<void>, PasscodeRoute {
  RenameAccountNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin RenameAccountRoute {
  Future<void> openRenameAccount(RenameAccountInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(getIt<RenameAccountPage>(param1: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
