import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:transaction_signing_gateway/model/credentials_storage_failure.dart';
import 'package:transaction_signing_gateway/model/transaction_signing_failure.dart';
import 'package:transaction_signing_gateway/model/wallet_lookup_key.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

/// Dumb version of the keyInfoStorage, that keeps wallets in the memory. If needed, we can come
/// up with something more sophisticated for web later on
class WebKeyInfoStorage implements KeyInfoStorage {
  final Map<String, PrivateWalletCredentials> _credentialsMap = {};

  @override
  Future<Either<CredentialsStorageFailure, PrivateWalletCredentials>> getPrivateCredentials(
    WalletLookupKey walletLookupKey,
  ) async {
    final creds = _credentialsMap[walletLookupKey.walletId];
    if (creds == null) {
      return left(const CredentialsStorageFailure("Credentials not found"));
    } else {
      return right(creds);
    }
  }

  @override
  Future<Either<CredentialsStorageFailure, Unit>> savePrivateCredentials({
    required PrivateWalletCredentials walletCredentials,
    required String password,
  }) async {
    _credentialsMap[walletCredentials.publicInfo.walletId] = walletCredentials;
    return right(unit);
  }

  @override
  Future<Either<CredentialsStorageFailure, List<WalletPublicInfo>>> getWalletsList() async =>
      right(_credentialsMap.entries.map((entry) => entry.value.publicInfo).toList());

  @override
  Future<Either<TransactionSigningFailure, bool>> verifyLookupKey(WalletLookupKey walletLookupKey) =>
      getPrivateCredentials(walletLookupKey) //
          .map((creds) => right(true))
          .leftMap((fail) => right(false));

  @override
  Future<Either<CredentialsStorageFailure, Unit>> updatePublicWalletInfo({required WalletPublicInfo info}) {
    // TODO: implement updatePublicWalletInfo
    throw UnimplementedError();
  }
}
