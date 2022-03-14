import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/navigation/snack_bar_route.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_page.dart';

class AccountManualBackupNavigator with NoRoutes, SnackBarRoute, CloseRoute<bool> {
  AccountManualBackupNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AccountManualBackupRoute {
  Future<bool?> openAccountManualBackup(AccountManualBackupInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(
          AccountManualBackupPage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
