import 'package:cosmos_ui_components/components/cosmos_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_initial_params.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_sheet.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_navigator.dart';
import 'package:flutter_app/ui/pages/edit_account/edit_account_navigator.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_navigator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AccountsListNavigator
    with
        NoRoutes,
        ErrorDialogRoute,
        AccountDetailsRoute,
        AddAccountRoute,
        ImportAccountRoute,
        CloseRoute,
        EditAccountRoute,
        PasscodeRoute,
        RoutingRoute,
        RenameAccountRoute {
  AccountsListNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AccountsListRoute {
  Future<void> openAccountsList(AccountsListInitialParams initialParams) async => showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => CosmosBottomSheetContainer(
          child: getIt<AccountsListSheet>(param1: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
