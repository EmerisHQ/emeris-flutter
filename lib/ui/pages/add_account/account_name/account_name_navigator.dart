import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_initial_params.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_page.dart';

class AccountNameNavigator with NoRoutes, CloseRoute<String> {
  AccountNameNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AccountNameRoute {
  Future<String?> openAccountName(AccountNameInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(getIt<AccountNamePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
