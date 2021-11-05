import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/send_money/enter_amount/enter_amount_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/recipient_address_input/recipient_address_input.dart';

class RecipientAddressInputNavigator with NoRoutes, ErrorDialogRoute, EnterAmountRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  RecipientAddressInputNavigator(this.appNavigator);
}

abstract class RecipientAddressInputRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  factory RecipientAddressInputRoute._() => throw UnsupportedError("This class is meant to be mixed in");

  Future<void> navigateToRecipientAddressInput() async =>
      appNavigator.push(context, materialRoute(const RecipientAddressInputPage()));
}
