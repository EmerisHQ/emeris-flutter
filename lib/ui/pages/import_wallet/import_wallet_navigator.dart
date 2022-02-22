import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_navigator.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_page.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';

class ImportWalletNavigator
    with CloseRoute<EmerisWallet>, PasscodeRoute, ErrorDialogRoute, WalletNameRoute, MnemonicImportRoute {
  ImportWalletNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin ImportWalletRoute {
  Future<EmerisWallet?> openImportWallet(
    ImportWalletInitialParams initialParams,
  ) async =>
      appNavigator.push(
        context,
        materialRoute(
          ImportWalletPage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
