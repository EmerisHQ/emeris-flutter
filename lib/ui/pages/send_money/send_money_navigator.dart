import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';

class SendMoneyNavigator with NoRoutes, SendMoneyRoute, ErrorDialogRoute {
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
}
