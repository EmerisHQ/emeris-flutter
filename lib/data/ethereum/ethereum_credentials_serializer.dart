import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/ethereum/ethereum_private_wallet_credentials.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';
import 'package:transaction_signing_gateway/model/private_account_credentials.dart';
import 'package:transaction_signing_gateway/model/private_account_credentials_serializer.dart';

class EthereumCredentialsSerializer implements PrivateAccountCredentialsSerializer {
  static const id = 'EthereumPrivateWalletCredentialsSerializer';

  static const _chainIdKey = 'chainId';
  static const _mnemonicKey = 'mnemonic';
  static const _publicAddressKey = 'publicAddress';
  static const _nameKey = 'name';
  static const _walletIdKey = 'walletId';
  static const _walletCoreJsonKey = 'walletCoreJson';
  static const _walletCorePasswordKey = 'walletCorePassword';

  @override
  Either<CredentialsStorageFailure, PrivateAccountCredentials> fromJson(Map<String, dynamic> json) {
    try {
      return right(
        EthereumPrivateWalletCredentials(
          publicInfo: AccountPublicInfo(
            chainId: json[_chainIdKey] as String? ?? '',
            publicAddress: json[_publicAddressKey] as String? ?? '',
            accountId: json[_walletIdKey] as String? ?? '',
            name: json[_nameKey] as String? ?? '',
          ),
          mnemonic: json[_mnemonicKey] as String? ?? '',
          walletCoreJson: json[_walletCoreJsonKey] as String? ?? '',
          walletCorePassword: json[_walletCorePasswordKey] as String? ?? '',
        ),
      );
    } catch (e, stack) {
      logError(e, stack);
      return left(CredentialsStorageFailure('Could not parse wallet credentials: $e'));
    }
  }

  @override
  String get identifier => id;

  @override
  Either<CredentialsStorageFailure, Map<String, dynamic>> toJson(PrivateAccountCredentials credentials) {
    if (credentials is! EthereumPrivateWalletCredentials) {
      return left(
        CredentialsStorageFailure(
          'Passed credentials are not of type $EthereumPrivateWalletCredentials. actual: $credentials',
        ),
      );
    }
    return right({
      _chainIdKey: credentials.publicInfo.chainId,
      _mnemonicKey: credentials.mnemonic,
      _walletIdKey: credentials.publicInfo.accountId,
      _nameKey: credentials.publicInfo.name,
      _publicAddressKey: credentials.publicInfo.publicAddress,
      _walletCoreJsonKey: credentials.walletCoreJson,
      _walletCorePasswordKey: credentials.walletCorePassword,
    });
  }
}
