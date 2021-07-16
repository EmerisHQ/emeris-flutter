import 'package:flutter_app/data/ethereum/ethereum_credentials_serializer.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';
import 'package:wallet_core/wallet_core.dart' as core;

class EthereumPrivateWalletCredentials implements PrivateWalletCredentials {
  @override
  String get serializerIdentifier => EthereumCredentialsSerializer.id;

  @override
  final WalletPublicInfo publicInfo;

  @override
  final String mnemonic;

  final String walletCoreJson;
  final String walletCorePassword;

  core.Wallet get wallet => core.Wallet.fromJson(walletCoreJson, walletCorePassword);

  EthereumPrivateWalletCredentials({
    required this.mnemonic,
    required this.publicInfo,
    required this.walletCoreJson,
    required this.walletCorePassword,
  });
}
