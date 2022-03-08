import 'package:flutter_app/data/ethereum/ethereum_credentials_serializer.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';
import 'package:wallet_core/wallet_core.dart' as core;

class EthereumPrivateAccountCredentials implements PrivateAccountCredentials {
  EthereumPrivateAccountCredentials({
    required this.mnemonic,
    required this.publicInfo,
    required this.accountCoreJson,
    required this.accountCorePassword,
  });

  @override
  String get serializerIdentifier => EthereumCredentialsSerializer.id;

  @override
  final AccountPublicInfo publicInfo;

  @override
  final String mnemonic;

  final String accountCoreJson;
  final String accountCorePassword;

  core.Wallet get account => core.Wallet.fromJson(accountCoreJson, accountCorePassword);
}
