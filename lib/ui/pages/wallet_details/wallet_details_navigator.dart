import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_page.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';

class WalletDetailsNavigator
    with NoRoutes, SendMoneyRoute, ErrorDialogRoute, WalletDetailsRoute, WalletsListRoute, AssetDetailsRoute {
  WalletDetailsNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin WalletDetailsRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  Future<void> openWalletDetails({bool replaceCurrent = false}) {
    const page = WalletDetailsPage(initialParams: WalletDetailsInitialParams());
    if (replaceCurrent) {
      return appNavigator.pushReplacement(context, fadeInRoute(page));
    } else {
      return appNavigator.push(context, materialRoute(page));
    }
  }
}
