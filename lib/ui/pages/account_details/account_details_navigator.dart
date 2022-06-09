import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_initial_params.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_page.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/receive/receive_navigator.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/ui/pages/settings/settings_navigator.dart';

class AccountDetailsNavigator
    with
        NoRoutes,
        SendTokensRoute,
        ErrorDialogRoute,
        AccountDetailsRoute,
        AccountsListRoute,
        AssetDetailsRoute,
        ReceiveRoute,
        SettingsRoute,
        ScanQrRoute {
  AccountDetailsNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AccountDetailsRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  Future<void> openAccountDetails({bool replaceCurrent = false}) {
    final page = getIt<AccountDetailsPage>(param1: const AccountDetailsInitialParams());
    if (replaceCurrent) {
      return appNavigator.pushReplacement(context, fadeInRoute(page));
    } else {
      return appNavigator.push(context, materialRoute(page));
    }
  }
}
