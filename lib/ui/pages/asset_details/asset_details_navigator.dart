import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_page.dart';
import 'package:flutter_app/ui/pages/receive/receive_navigator.dart';

class AssetDetailsNavigator with NoRoutes, ErrorDialogRoute, ReceiveRoute {
  AssetDetailsNavigator(this.appNavigator);

  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;
}

mixin AssetDetailsRoute {
  Future<void> openAssetDetails(AssetDetailsInitialParams initialParams) => appNavigator.push(
        context,
        materialRoute(
          AssetDetailsPage(
            initialParams: initialParams,
          ),
        ),
      );

  AppNavigator get appNavigator;

  BuildContext get context;
}
