import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/recipient_address_input/recipient_address_input.dart';

abstract class RecipientAddressInputRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  factory RecipientAddressInputRoute._() => throw UnsupportedError("This class is meant to be mixed in");

  Future<void> navigateToRecipientAddressInput() async =>
      appNavigator.push(context, materialRoute(const RecipientAddressInputPage()));
}
