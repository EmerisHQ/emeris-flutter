import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_page.dart';

class MnemonicImportNavigator with NoRoutes, CloseRoute<Mnemonic>, ErrorDialogRoute {
  MnemonicImportNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin MnemonicImportRoute {
  Future<Mnemonic?> openMnemonicImport(MnemonicImportInitialParams initialParams) => appNavigator.push(
        context,
        materialRoute(
          MnemonicImportPage(initialParams: initialParams),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
