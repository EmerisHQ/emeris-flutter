import 'package:cosmos_utils/extensions.dart';
import 'package:flutter/material.dart' as ui;
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

class SettingsStore with _SettingsStoreBase {
  bool get hasPasscode => _hasPasscode.value;

  ui.Brightness get brightness => _brightness.value;

  Future<void> init(AuthRepository _authRepository) async {
    hasPasscode = await _authRepository.hasPasscode().asyncFold(
          (fail) => false,
          (hasPasscode) => hasPasscode,
        );
  }
}

mixin _SettingsStoreBase {
  //////////////////////////////////////
  final Observable<bool> _hasPasscode = Observable(false);

  set hasPasscode(bool value) => Action(() => _hasPasscode.value = value)();

  //////////////////////////////////////
  final Observable<ui.Brightness> _brightness = Observable(ui.Brightness.dark);

  set brightness(ui.Brightness value) => Action(() => _brightness.value = value)();
}
