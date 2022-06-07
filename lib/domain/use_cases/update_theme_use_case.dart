import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/domain/entities/failures/update_theme_failure.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';

class UpdateThemeUseCase {
  UpdateThemeUseCase(this._settingsStore);

  final SettingsStore _settingsStore;

  Future<Either<UpdateThemeFailure, Unit>> execute({
    required Brightness brightness,
  }) async {
    _settingsStore.brightness = brightness;
    return right(unit);
  }
}
