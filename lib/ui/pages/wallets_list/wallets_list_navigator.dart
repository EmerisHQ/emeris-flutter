import 'package:cosmos_ui_components/components/cosmos_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WalletsListNavigator with NoRoutes, ErrorDialogRoute, WalletDetailsRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  WalletsListNavigator(this.appNavigator);
}

abstract class WalletsListRoute {
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

  factory WalletsListRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
