import 'package:flutter/material.dart';
import 'package:flutter_app/domain/use_cases/update_theme_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/settings/settings_navigator.dart';
import 'package:flutter_app/ui/pages/settings/settings_presentation_model.dart';

class SettingsPresenter {
  SettingsPresenter(
    this._model,
    this.navigator,
    this._updateThemeUseCase,
  );

  final SettingsNavigator navigator;

  final SettingsPresentationModel _model;

  final UpdateThemeUseCase _updateThemeUseCase;

  SettingsViewModel get viewModel => _model;

  void onTapClose() => navigator.close();

  void onTapBackup() => showNotImplemented();

  void onTapSecurity() => showNotImplemented();

  void onTapCurrency() => showNotImplemented();

  void onTapCommunity() => showNotImplemented();

  void onTapTwitter() => showNotImplemented();

  void onTapSupport() => showNotImplemented();

  void onTapSignOut() => showNotImplemented();

  // ignore: avoid_positional_boolean_parameters
  void onThemeUpdated(bool value) => _updateThemeUseCase.execute(
        brightness: value ? Brightness.dark : Brightness.light,
      );
}
