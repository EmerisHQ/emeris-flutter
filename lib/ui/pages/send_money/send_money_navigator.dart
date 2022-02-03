import 'package:cosmos_ui_components/components/cosmos_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_bottom_sheet.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_initial_params.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SendMoneyNavigator with NoRoutes, ErrorDialogRoute, PasscodeRoute, CloseRoute {
  SendMoneyNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin SendMoneyRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  Future<void> openSendMoneySheet(SendMoneyInitialParams initialParams) async {
    await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => CosmosBottomSheetContainer(
        child: SendMoneySheet(
          initialParams: initialParams,
        ),
      ),
    );
  }
}
