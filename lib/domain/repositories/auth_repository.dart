import 'package:cosmos_auth/cosmos_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/model/failures/save_passcode_failure.dart';
import 'package:flutter_app/domain/model/failures/verify_passcode_failure.dart';

abstract class AuthRepository {
  Future<Either<ReadPasswordFailure, bool>> hasPasscode();

  Future<Either<VerifyPasscodeFailure, bool>> verifyPasscode(Passcode passcode);

  Future<Either<SavePasscodeFailure, Unit>> savePasscode(Passcode passcode);
}
