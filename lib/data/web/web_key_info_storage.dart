import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:transaction_signing_gateway/model/account_lookup_key.dart';
import 'package:transaction_signing_gateway/model/transaction_signing_failure.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

/// Dumb version of the keyInfoStorage, that keeps wallets in the memory. If needed, we can come
/// up with something more sophisticated for web later on
class WebKeyInfoStorage implements KeyInfoStorage {
  final Map<String, PrivateAccountCredentials> _credentialsMap = {};

  @override
  Future<Either<CredentialsStorageFailure, PrivateAccountCredentials>> getPrivateCredentials(
    AccountLookupKey walletLookupKey,
  ) async {
    final creds = _credentialsMap[walletLookupKey.accountId];
    if (creds == null) {
      return left(const CredentialsStorageFailure('Credentials not found'));
    } else {
      return right(creds);
    }
  }

  // @override
  // Future<Either<CredentialsStorageFailure, Unit>> savePrivateCredentials({
  //   required PrivateAccountCredentials walletCredentials,
  //   required String password,
  // }) async {

  // }

  @override
  Future<Either<CredentialsStorageFailure, List<AccountPublicInfo>>> getAccountsList() async =>
      right(_credentialsMap.entries.map((entry) => entry.value.publicInfo).toList());

  @override
  Future<Either<TransactionSigningFailure, bool>> verifyLookupKey(AccountLookupKey walletLookupKey) =>
      getPrivateCredentials(walletLookupKey) //
          .map((creds) => right(true))
          .leftMap((fail) => right(false));

  @override
  Future<Either<CredentialsStorageFailure, Unit>> updatePublicAccountInfo({required AccountPublicInfo info}) {
    // TODO: implement updatePublicWalletInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<CredentialsStorageFailure, Unit>> deleteAccountCredentials({required AccountPublicInfo publicInfo}) {
    // TODO: implement deleteWalletCredentials
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
}
