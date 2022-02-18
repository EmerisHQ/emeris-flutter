import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_initial_params.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_page.dart';

class SendMoneyNavigator with NoRoutes {
  SendMoneyNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin SendMoneyRoute {
  Future<void> openSendMoney(SendMoneyInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(getIt<SendMoneyPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
