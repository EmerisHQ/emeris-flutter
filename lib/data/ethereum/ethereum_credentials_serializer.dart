import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/ethereum/ethereum_private_wallet_credentials.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:transaction_signing_gateway/model/credentials_storage_failure.dart';
import 'package:transaction_signing_gateway/model/private_wallet_credentials.dart';
import 'package:transaction_signing_gateway/model/private_wallet_credentials_serializer.dart';

class EthereumCredentialsSerializer implements PrivateWalletCredentialsSerializer {
  static const id = "EthereumPrivateWalletCredentialsSerializer";

  static const _chainIdKey = "chainId";
  static const _mnemonicKey = "mnemonic";
  static const walletIdKey = "walletId";
  static const _walletCoreJsonKey = "walletCoreJson";
  static const _walletCorePasswordKey = "walletCorePassword";

  @override
  Either<CredentialsStorageFailure, PrivateWalletCredentials> fromJson(Map<String, dynamic> json) {
    try {
      return right(EthereumPrivateWalletCredentials(
        chainId: json[_chainIdKey] as String? ?? "",
        mnemonic: json[_mnemonicKey] as String? ?? "",
        walletId: json[walletIdKey] as String? ?? "",
        walletCoreJson: json[_walletCoreJsonKey] as String? ?? "",
        walletCorePassword: json[_walletCorePasswordKey] as String? ?? "",
      ));
    } catch (e, stack) {
      logError(e, stack);
      return left(CredentialsStorageFailure("Could not parse wallet credentials: $e"));
    }
  }

  @override
  String get identifier => id;

  @override
  Either<CredentialsStorageFailure, Map<String, dynamic>> toJson(PrivateWalletCredentials credentials) {
    if (credentials is! EthereumPrivateWalletCredentials) {
      return left(CredentialsStorageFailure(
          "Passed credentials are not of type $EthereumPrivateWalletCredentials. actual: $credentials"));
    }
    return right({
      _chainIdKey: credentials.chainId,
      _mnemonicKey: credentials.mnemonic,
      walletIdKey: credentials.walletId,
      _walletCoreJsonKey: credentials.walletCoreJson,
      _walletCorePasswordKey: credentials.walletCorePassword,
    });
  }
}
