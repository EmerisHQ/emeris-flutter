import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_page.dart';

class WalletCloudBackupNavigator with NoRoutes {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  WalletCloudBackupNavigator(this.appNavigator);
}

abstract class WalletCloudBackupRoute {
  Future<void> openWalletCloudBackup(WalletCloudBackupInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(
          WalletCloudBackupPage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;

  factory WalletCloudBackupRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
