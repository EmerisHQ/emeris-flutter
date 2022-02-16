import 'package:cosmos_ui_components/components/cosmos_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/snack_bar_route.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';
import 'package:flutter_app/ui/pages/receive/receive_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ReceiveNavigator with CloseRoute, SnackBarRoute, ErrorDialogRoute {
  ReceiveNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin ReceiveRoute {
  Future<void> openReceive(ReceiveInitialParams initialParams) async => showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => CosmosBottomSheetContainer(
          child: ReceivePage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
