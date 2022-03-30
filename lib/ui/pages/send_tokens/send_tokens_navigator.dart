import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/broadcast_transaction.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_page.dart';

class SendTokensNavigator with CloseRoute<BroadcastTransaction>, BalanceSelectorRoute, PasscodeRoute, ErrorDialogRoute {
  SendTokensNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin SendTokensRoute {
  Future<BroadcastTransaction?> openSendTokens(SendTokensInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(getIt<SendTokensPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
