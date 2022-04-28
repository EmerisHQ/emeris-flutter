import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_page.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/backup_later_confirmation_sheet.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_navigator.dart';

class AccountBackupIntroNavigator
    with AccountCloudBackupRoute, AccountManualBackupRoute, BackupLaterConfirmationRoute, CloseRoute<bool> {
  AccountBackupIntroNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AccountBackupIntroRoute {
  Future<bool?> openAccountBackup(
    AccountBackupIntroInitialParams initialParams,
  ) async =>
      appNavigator.push(
        context,
        materialRoute(getIt<AccountBackupIntroPage>(param1: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
