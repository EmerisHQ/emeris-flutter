import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';

abstract class SnackBarRoute {
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

  factory SnackBarRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
