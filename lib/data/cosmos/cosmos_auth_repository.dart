import 'package:cosmos_auth/cosmos_auth.dart';
import 'package:cosmos_utils/data_store.dart';
import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/model/failures/save_passcode_failure.dart';
import 'package:flutter_app/domain/model/failures/verify_passcode_failure.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';

class CosmosAuthRepository implements AuthRepository {
  const CosmosAuthRepository(
    this._cosmosAuth,
    this._secureDataStore,
  );

  static const emerisPasscodeId = 'emeris_passcode_id';
  final CosmosAuth _cosmosAuth;
  final SecureDataStore _secureDataStore;

  @override
  Future<Either<ReadPasswordFailure, bool>> hasPasscode() => _cosmosAuth.hasPassword(
        id: emerisPasscodeId,
        secureDataStore: _secureDataStore,
      );

  @override
  Future<Either<VerifyPasscodeFailure, bool>> verifyPasscode(
    Passcode passcode,
  ) async {
    final validate = passcode.validateError();
    if (validate != null) {
      return left(VerifyPasscodeFailure.validationError(validate));
    }
    return _cosmosAuth
        .readPassword(
          secureDataStore: _secureDataStore,
          id: emerisPasscodeId,
          useBiometrics: false,
        )
        .mapError(VerifyPasscodeFailure.unknown)
        .mapSuccess((pass) => pass == passcode.value);
  }

  @override
  Future<Either<SavePasscodeFailure, Unit>> savePasscode(
    Passcode passcode,
  ) async {
    final validate = passcode.validateError();
    if (validate != null) {
      return left(SavePasscodeFailure.validationError(validate));
    }
    return _cosmosAuth
        .savePassword(
          secureDataStore: _secureDataStore,
          id: emerisPasscodeId,
          password: passcode.value,
        )
        .mapError(SavePasscodeFailure.unknown);
  }
}
