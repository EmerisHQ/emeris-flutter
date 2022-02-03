import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/model/failures/save_passcode_failure.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';

class SavePasscodeUseCase {
  const SavePasscodeUseCase(this._authRepository, this._settingsStore);

  final AuthRepository _authRepository;
  final SettingsStore _settingsStore;

  Future<Either<SavePasscodeFailure, Unit>> execute(
    Passcode passcode,
  ) =>
      _authRepository.savePasscode(passcode).doOn(
            success: (_) => _settingsStore.hasPasscode = true,
          );
}
