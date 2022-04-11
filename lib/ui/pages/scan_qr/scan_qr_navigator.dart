import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/close_route.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_initial_params.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_page.dart';

class ScanQrNavigator with CloseRoute<void>, ErrorDialogRoute {
  ScanQrNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin ScanQrRoute {
  Future<void> openScanQr(ScanQrInitialParams initialParams) {
    return appNavigator.push(
      context,
      materialRoute(getIt<ScanQrPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;
}
