import 'package:cosmos_utils/extensions.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

class SettingsStore with _SettingsStoreBase {
  bool get hasPasscode => _hasPasscode.value;

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
}