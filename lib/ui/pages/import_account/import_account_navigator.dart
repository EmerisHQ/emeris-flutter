import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/add_account/account_name/account_name_navigator.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_initial_params.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_page.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';

class ImportAccountNavigator
    with CloseRoute<EmerisAccount>, PasscodeRoute, ErrorDialogRoute, AccountNameRoute, MnemonicImportRoute {
  ImportAccountNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin ImportAccountRoute {
  Future<EmerisAccount?> openImportAccount(
    ImportAccountInitialParams initialParams,
  ) async =>
      appNavigator.push(
        context,
        materialRoute(
          ImportAccountPage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
