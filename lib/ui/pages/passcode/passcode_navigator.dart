import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_page.dart';

class PasscodeNavigator with NoRoutes, CloseRoute<Passcode>, ErrorDialogRoute {
  PasscodeNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin PasscodeRoute {
  Future<Passcode?> openPasscode(PasscodeInitialParams initialParams) async => appNavigator.push(
        context,
        materialRoute(PasscodePage(initialParams: initialParams)),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
