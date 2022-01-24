import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/presentation/asset_details/asset_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';

class AssetDetailsPresenter {
  final AssetDetailsPresentationModel _model;
  final AssetDetailsNavigator navigator;

  AssetDetailsViewModel get viewModel => _model;

  AssetDetailsPresenter(this._model, this.navigator);

  void onReceivePressed() => showNotImplemented();

  void onSendPressed() => showNotImplemented();
}
