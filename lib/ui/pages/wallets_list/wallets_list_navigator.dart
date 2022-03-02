import 'package:cosmos_ui_components/components/cosmos_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/edit_wallet/edit_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WalletsListNavigator
    with
        NoRoutes,
        ErrorDialogRoute,
        WalletDetailsRoute,
        AddWalletRoute,
        ImportWalletRoute,
        CloseRoute,
        EditWalletRoute,
        PasscodeRoute,
        RoutingRoute {
  WalletsListNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin WalletsListRoute {
  Future<void> openWalletsList(WalletsListInitialParams initialParams) async => showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const CosmosBottomSheetContainer(
          child: WalletsListSheet(
            initialParams: WalletsListInitialParams(),
          ),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
