import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/presentation/send_money/send_money_initial_params.dart';
import 'package:flutter_app/ui/pages/send_money/send_money.dart';
import 'package:flutter_app/ui/pages/send_money/send_to_selection/send_to_selection.dart';

class SendMoneyNavigator with NoRoutes, ErrorDialogRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  SendMoneyNavigator(this.appNavigator);
}

abstract class SendMoneyRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  factory SendMoneyRoute._() => throw UnsupportedError("This class is meant to be mixed in");

  Future<void> navigateToSendSelectionPage() async =>
      appNavigator.push(context, materialRoute(const SendToSelectionPage()));

  Future<void> openSendMoneySheet(SendMoneyInitialParams initialParams) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: SendMoneySheet(
          initialParams: initialParams,
        ),
      ),
    );
  }
}
