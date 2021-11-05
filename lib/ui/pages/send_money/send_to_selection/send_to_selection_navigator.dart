import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/send_money/recipient_address_input/recipient_address_input_navigator.dart';

class SendToSelectionNavigator with NoRoutes, ErrorDialogRoute, RecipientAddressInputRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  SendToSelectionNavigator(this.appNavigator);
}
