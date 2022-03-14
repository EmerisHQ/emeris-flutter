import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/utils/strings.dart';

mixin EditAccountRoute {
  Future<void> openEditAccountSheet({
    required String title,
    VoidCallback? onTapRename,
    VoidCallback? onTapDelete,
  }) async =>
      showCosmosActionSheet(
        context: context,
        actions: [
          CosmosModalAction(
            text: strings.renameAccountAction,
            onPressed: onTapRename ?? showNotImplemented,
          ),
          CosmosModalAction(
            text: strings.deleteAccountAction,
            onPressed: onTapDelete ?? showNotImplemented,
            isCriticalAction: true,
          ),
        ],
        title: Text(title),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
