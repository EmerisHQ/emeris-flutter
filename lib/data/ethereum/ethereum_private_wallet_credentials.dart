import 'package:flutter_app/data/ethereum/ethereum_credentials_serializer.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';
import 'package:wallet_core/wallet_core.dart' as core;

class EthereumPrivateWalletCredentials implements PrivateWalletCredentials {
  @override
  String get serializerIdentifier => EthereumCredentialsSerializer.id;

  @override
  String chainId;
  @override
  final String mnemonic;
  @override
  final String walletId;
  final String walletCoreJson;
  final String walletCorePassword;

  core.Wallet get wallet => core.Wallet.fromJson(walletCoreJson, walletCorePassword);

  EthereumPrivateWalletCredentials({
    required this.chainId,
    required this.mnemonic,
    required this.walletId,
    required this.walletCoreJson,
    required this.walletCorePassword,
  });
}
