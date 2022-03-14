import 'package:cosmos_ui_components/components/cosmos_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BalanceSelectorNavigator with NoRoutes, CloseRoute<ChainAsset>, ErrorDialogRoute {
  BalanceSelectorNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin BalanceSelectorRoute {
  Future<ChainAsset?> openBalanceSelector(BalanceSelectorInitialParams initialParams) async {
    return showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => CosmosBottomSheetContainer(
        child: getIt<BalanceSelectorPage>(param1: initialParams),
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
