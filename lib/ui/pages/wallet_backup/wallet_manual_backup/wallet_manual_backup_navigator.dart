import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/navigation/snack_bar_route.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_page.dart';

class WalletManualBackupNavigator with NoRoutes, SnackBarRoute, CloseRoute<bool> {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  WalletManualBackupNavigator(this.appNavigator);
}

abstract class WalletManualBackupRoute {
  Future<bool?> openWalletManualBackup(WalletManualBackupInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(
          WalletManualBackupPage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;

  factory WalletManualBackupRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
