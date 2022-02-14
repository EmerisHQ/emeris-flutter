#set( $ClassName = ${StringUtils.removeAndHump(${NAME}, "_")})
#set( $parentPackage = "#if(${PARENT.isEmpty()})#else${PARENT}/#end")

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/${parentPackage}${NAME}/${NAME}_initial_params.dart';

class ${ClassName}Navigator with NoRoutes {
  ${ClassName}Navigator(this.appNavigator);
  
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin ${ClassName}Route {

  Future<void> open${ClassName}(${ClassName}InitialParams initialParams) async { TODO() }

  AppNavigator get appNavigator;

  BuildContext get context;
}