import 'package:flutter_app/ui/pages/settings/settings_initial_params.dart';

abstract class SettingsViewModel {}

class SettingsPresentationModel with SettingsPresentationModelBase implements SettingsViewModel {
  SettingsPresentationModel(this.initialParams);

  final SettingsInitialParams initialParams;
}

abstract class SettingsPresentationModelBase {}
