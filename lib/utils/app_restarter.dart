import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AppRestarter extends StatelessWidget {
  const AppRestarter({
    required this.child,
    Key? key,
  }) : super(key: key);

  static void restartApp() {
    getIt.reset();
    final context = AppNavigator.navigatorKey.currentContext;
    if (context != null) {
      Phoenix.rebirth(context);
    }
  }

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: child,
    );
  }
}
