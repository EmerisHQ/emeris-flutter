import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';

mixin SnackBarRoute {
  Future<void> showSnackBar(
    String text,
  ) async =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
