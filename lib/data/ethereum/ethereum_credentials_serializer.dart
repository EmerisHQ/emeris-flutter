import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/ethereum/ethereum_private_account_credentials.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';
import 'package:transaction_signing_gateway/model/private_account_credentials.dart';
import 'package:transaction_signing_gateway/model/private_account_credentials_serializer.dart';

class EthereumCredentialsSerializer implements PrivateAccountCredentialsSerializer {
  static const id = 'EthereumPrivateAccountCredentialsSerializer';

  static const _chainIdKey = 'chainId';
  static const _mnemonicKey = 'mnemonic';
  static const _publicAddressKey = 'publicAddress';
  static const _nameKey = 'name';
  static const _accountIdKey = 'accountId';
  static const _accountCoreJsonKey = 'accountCoreJson';
  static const _accountCorePasswordKey = 'accountCorePassword';

  @override
  Either<CredentialsStorageFailure, PrivateAccountCredentials> fromJson(Map<String, dynamic> json) {
    try {
      return right(
        EthereumPrivateAccountCredentials(
          publicInfo: AccountPublicInfo(
            chainId: json[_chainIdKey] as String? ?? '',
            publicAddress: json[_publicAddressKey] as String? ?? '',
            accountId: json[_accountIdKey] as String? ?? '',
            name: json[_nameKey] as String? ?? '',
          ),
          mnemonic: json[_mnemonicKey] as String? ?? '',
          accountCoreJson: json[_accountCoreJsonKey] as String? ?? '',
          accountCorePassword: json[_accountCorePasswordKey] as String? ?? '',
        ),
      );
    } catch (e, stack) {
      logError(e, stack);
      return left(CredentialsStorageFailure('Could not parse account credentials: $e'));
    }
  }

  @override
  String get identifier => id;

  @override
  Either<CredentialsStorageFailure, Map<String, dynamic>> toJson(PrivateAccountCredentials credentials) {
    if (credentials is! EthereumPrivateAccountCredentials) {
      return left(
        CredentialsStorageFailure(
          'Passed credentials are not of type $EthereumPrivateAccountCredentials. actual: $credentials',
        ),
      );
    }
    return right({
      _chainIdKey: credentials.publicInfo.chainId,
      _mnemonicKey: credentials.mnemonic,
      _accountIdKey: credentials.publicInfo.accountId,
      _nameKey: credentials.publicInfo.name,
      _publicAddressKey: credentials.publicInfo.publicAddress,
      _accountCoreJsonKey: credentials.accountCoreJson,
      _accountCorePasswordKey: credentials.accountCorePassword,
    });
  }
}
