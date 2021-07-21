import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emeris_app/data/model/emeris_wallet.dart';
import 'package:emeris_app/navigation/app_navigator.dart';
import 'package:emeris_app/navigation/error_dialog_route.dart';
import 'package:emeris_app/navigation/no_routes.dart';
import 'package:emeris_app/presentation/wallet_details/wallet_details_initial_params.dart';
import 'package:emeris_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:emeris_app/ui/pages/wallet_details/wallet_details_page.dart';

class WalletDetailsNavigator with NoRoutes, SendMoneyRoute, ErrorDialogRoute, WalletDetailsRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  WalletDetailsNavigator(this.appNavigator);
}

abstract class WalletDetailsRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  factory WalletDetailsRoute._() => throw UnsupportedError("This class is meant to be mixed in");

  Future<void> openWalletDetails(EmerisWallet wallet) => appNavigator.push(
        context,
        materialRoute(
          WalletDetailsPage(
            initialParams: WalletDetailsInitialParams(wallet),
          ),
        ),
      );
}
