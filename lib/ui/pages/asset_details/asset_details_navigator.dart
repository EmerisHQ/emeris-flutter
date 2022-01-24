import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/navigation/error_dialog_route.dart';
import 'package:flutter_app/navigation/no_routes.dart';
import 'package:flutter_app/presentation/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_page.dart';

class AssetDetailsNavigator with NoRoutes, ErrorDialogRoute {
  @override
  late BuildContext context;
  @override
  final AppNavigator appNavigator;

  AssetDetailsNavigator(this.appNavigator);
}

abstract class AssetDetailsRoute {
  Future<void> openAssetDetails({required Balance balance, required AssetDetails assetDetails}) async {
    appNavigator.push(
      context,
      materialRoute(
        AssetDetailsPage(
          initialParams: AssetDetailsInitialParams(
            balance: balance,
            assetDetails: assetDetails,
          ),
        ),
      ),
    );
  }

  AppNavigator get appNavigator;

  BuildContext get context;

  factory AssetDetailsRoute._() => throw UnsupportedError("This class is meant to be mixed in");
}
