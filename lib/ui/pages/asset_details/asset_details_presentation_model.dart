import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';

abstract class AssetDetailsViewModel {}

class AssetDetailsPresentationModel with AssetDetailsPresentationModelBase implements AssetDetailsViewModel {
  AssetDetailsPresentationModel(
    this.initialParams,
  );

  final AssetDetailsInitialParams initialParams;
}

mixin AssetDetailsPresentationModelBase {}
