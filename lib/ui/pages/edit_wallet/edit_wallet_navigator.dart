import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';

mixin EditWalletRoute {
  Future<void> openEditWalletSheet({
    required String title,
    VoidCallback? onTapRename,
    VoidCallback? onTapDelete,
  }) async =>
      showCosmosActionSheet(
        context: context,
        actions: [
          CosmosModalAction(
            text: 'Rename Account',
            onPressed: onTapRename ?? showNotImplemented,
          ),
          CosmosModalAction(
            text: 'Delete Account',
            onPressed: onTapDelete ?? showNotImplemented,
            isCriticalAction: true,
          ),
        ],
        title: Text(title),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
