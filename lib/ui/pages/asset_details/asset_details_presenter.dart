import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presentation_model.dart';

class AssetDetailsPresenter {
  AssetDetailsPresenter(this._model, this.navigator);

  final AssetDetailsPresentationModel _model;
  final AssetDetailsNavigator navigator;

  AssetDetailsViewModel get viewModel => _model;

  void onReceivePressed() => showNotImplemented();

  void onSendPressed() => showNotImplemented();
}
