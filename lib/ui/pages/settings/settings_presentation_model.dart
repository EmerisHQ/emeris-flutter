import 'package:flutter/cupertino.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/ui/pages/settings/settings_initial_params.dart';

abstract class SettingsViewModel {
  bool get isDarkTheme;
}

class SettingsPresentationModel with SettingsPresentationModelBase implements SettingsViewModel {
  SettingsPresentationModel(this.initialParams, this._settingsStore);

  final SettingsInitialParams initialParams;
  final SettingsStore _settingsStore;

  @override
  bool get isDarkTheme => _settingsStore.brightness == Brightness.dark;
}

abstract class SettingsPresentationModelBase {}
