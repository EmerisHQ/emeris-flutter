import 'package:flutter/material.dart';
import 'package:flutter_app/app_configurator.dart';
import 'package:flutter_app/app_widget.dart';
import 'package:flutter_app/utils/app_restarter.dart';

void main() {
  runApp(
    const AppRestarter(
      child: AppConfigurator(
        child: AppWidget(),
      ),
    ),
  );
}
