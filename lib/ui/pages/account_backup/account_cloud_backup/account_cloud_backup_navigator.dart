import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_page.dart';

class AccountCloudBackupNavigator with NoRoutes {
  AccountCloudBackupNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AccountCloudBackupRoute {
  Future<void> openAccountCloudBackup(AccountCloudBackupInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(
          AccountCloudBackupPage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
