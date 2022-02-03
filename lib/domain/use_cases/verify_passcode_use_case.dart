import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/model/failures/verify_passcode_failure.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';

class VerifyPasscodeUseCase {
  const VerifyPasscodeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Checks whether persisted passcode is matching with the passed [passcode]
  Future<Either<VerifyPasscodeFailure, bool>> execute(
    Passcode passcode,
  ) async =>
      _authRepository.verifyPasscode(passcode);
}
