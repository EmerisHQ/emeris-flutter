import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/enter_amount/enter_amount.dart';

abstract class EnterAmountRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  factory EnterAmountRoute._() => throw UnsupportedError("This class is meant to be mixed in");

  Future<void> navigateToEnterAmount() async => appNavigator.push(context, materialRoute(const EnterAmountPage()));
}
