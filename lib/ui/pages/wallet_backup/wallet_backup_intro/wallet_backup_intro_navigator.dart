import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/backup_later_confirmation_sheet.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_page.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_navigator.dart';

class WalletBackupIntroNavigator
    with WalletCloudBackupRoute, WalletManualBackupRoute, BackupLaterConfirmationRoute, RoutingRoute {
  WalletBackupIntroNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin WalletBackupIntroRoute {
  Future<void> openWalletBackup(WalletBackupIntroInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(
          WalletBackupIntroPage(
            initialParams: initialParams,
          ),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
