import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_page.dart';

class WalletNameNavigator with NoRoutes, CloseRoute<String> {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  WalletNameNavigator(this.appNavigator);
}

abstract class WalletNameRoute {
  Future<String?> openWalletName(WalletNameInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(WalletNamePage(initialParams: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;

  factory WalletNameRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
