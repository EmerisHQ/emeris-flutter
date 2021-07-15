import 'package:dartz/dartz.dart';
import 'package:transaction_signing_gateway/key_info_storage.dart';
import 'package:transaction_signing_gateway/model/credentials_storage_failure.dart';
import 'package:transaction_signing_gateway/model/private_wallet_credentials.dart';

/// Dumb version of the keyInfoStorage, that keeps wallets in the memory. If needed, we can come
/// up with something more sophisticated for web later on
class WebKeyInfoStorage implements KeyInfoStorage {
  final Map<String, PrivateWalletCredentials> _credentialsMap = {};

  @override
  Future<Either<CredentialsStorageFailure, PrivateWalletCredentials>> getPrivateCredentials(
      {required String chainId, required String walletId, required String password}) async {
    final creds = _credentialsMap[walletId];
    if (creds == null) {
      return left(const CredentialsStorageFailure("Credentials not found"));
    } else {
      return right(creds);
    }
  }

  @override
  Future<Either<CredentialsStorageFailure, Unit>> savePrivateCredentials(
      {required PrivateWalletCredentials walletCredentials, required String password}) async {
    _credentialsMap[walletCredentials.walletId] = walletCredentials;
    return right(unit);
  }
}
