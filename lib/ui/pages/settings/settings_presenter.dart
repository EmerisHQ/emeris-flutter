import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/settings/settings_navigator.dart';
import 'package:flutter_app/ui/pages/settings/settings_presentation_model.dart';

class SettingsPresenter {
  SettingsPresenter(
    this._model,
    this.navigator,
  );

  final SettingsNavigator navigator;

  final SettingsPresentationModel _model;

  SettingsViewModel get viewModel => _model;

  void onTapClose() => navigator.close();

  void onTapBackup() => showNotImplemented();

  void onTapSecurity() => showNotImplemented();

  void onTapCurrency() => showNotImplemented();

  void onTapCommunity() => showNotImplemented();

  void onTapTwitter() => showNotImplemented();

  void onTapSupport() => showNotImplemented();

  void onTapSignOut() => showNotImplemented();
}
