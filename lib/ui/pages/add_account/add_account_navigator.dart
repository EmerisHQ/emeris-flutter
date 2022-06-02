import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_page.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_result.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';

class AddAccountNavigator
    with
        NoRoutes,
        CloseRoute<AddAccountResult>,
        PasscodeRoute,
        ErrorDialogRoute,
        AccountNameRoute,
        AccountBackupIntroRoute {
  AddAccountNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AddAccountRoute {
  Future<AddAccountResult?> openAddAccount(AddAccountInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(getIt<AddAccountPage>(param1: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
