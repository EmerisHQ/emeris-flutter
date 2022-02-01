import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';

/// used with navigators that don't have any routes (yet).
mixin NoRoutes {
  BuildContext get context;

  AppNavigator get appNavigator;
}
