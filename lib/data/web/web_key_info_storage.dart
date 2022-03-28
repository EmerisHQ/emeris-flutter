import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:transaction_signing_gateway/model/account_lookup_key.dart';
import 'package:transaction_signing_gateway/model/clear_credentials_failure.dart';
import 'package:transaction_signing_gateway/model/transaction_signing_failure.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

/// Dumb version of the keyInfoStorage, that keeps accounts in the memory. If needed, we can come
/// up with something more sophisticated for web later on
class WebKeyInfoStorage implements KeyInfoStorage {
  final Map<String, PrivateAccountCredentials> _credentialsMap = {};

  @override
  Future<Either<CredentialsStorageFailure, PrivateAccountCredentials>> getPrivateCredentials(
    AccountLookupKey accountLookupKey,
  ) async {
    final creds = _credentialsMap[accountLookupKey.accountId];
    if (creds == null) {
      return left(const CredentialsStorageFailure('Credentials not found'));
    } else {
      return right(creds);
    }
  }

  @override
  Future<Either<CredentialsStorageFailure, List<AccountPublicInfo>>> getAccountsList() async =>
      right(_credentialsMap.entries.map((entry) => entry.value.publicInfo).toList());

  @override
  Future<Either<TransactionSigningFailure, bool>> verifyLookupKey(AccountLookupKey accountLookupKey) =>
      getPrivateCredentials(accountLookupKey) //
          .map((creds) => right(true))
          .leftMap((fail) => right(false));

  @override
  Future<Either<CredentialsStorageFailure, Unit>> updatePublicAccountInfo({required AccountPublicInfo info}) {
    // TODO: implement updatePublicAccountInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<CredentialsStorageFailure, Unit>> deleteAccountCredentials({required AccountPublicInfo publicInfo}) {
    // TODO: implement deleteAccountCredentials
    throw UnimplementedError();
  }

  @override
  Future<Either<CredentialsStorageFailure, Unit>> savePrivateCredentials({
    required PrivateAccountCredentials accountCredentials,
    required String password,
  }) async {
    _credentialsMap[accountCredentials.publicInfo.accountId] = accountCredentials;
    return right(unit);
  }

  @override
  Future<Either<ClearCredentialsFailure, Unit>> clearCredentials() async {
    _credentialsMap.clear();
    return right(unit);
  }
}
