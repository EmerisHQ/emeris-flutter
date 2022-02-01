import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_page.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_result.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';

class AddWalletNavigator with NoRoutes, CloseRoute<AddWalletResult>, PasscodeRoute, ErrorDialogRoute, WalletNameRoute {
  AddWalletNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AddWalletRoute {
  Future<AddWalletResult?> openAddWallet(AddWalletInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(AddWalletPage(initialParams: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
