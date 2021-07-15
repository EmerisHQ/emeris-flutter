import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/sacco/sacco_credentials_serializer.dart';
import 'package:sacco/sacco.dart' as sacco;
import 'package:transaction_signing_gateway/model/private_wallet_credentials.dart';

class SaccoPrivateWalletCredentials extends Equatable implements PrivateWalletCredentials {
  @override
  final String chainId;

  @override
  final String mnemonic;

  @override
  final String walletId;

  final sacco.NetworkInfo networkInfo;

  const SaccoPrivateWalletCredentials({
    required this.chainId,
    required this.mnemonic,
    required this.walletId,
    required this.networkInfo,
  });

  sacco.Wallet get saccoWallet => sacco.Wallet.derive(
        mnemonic.split(" "),
        networkInfo,
      );

  @override
  String get serializerIdentifier => SaccoCredentialsSerializer.id;

  @override
  List<Object?> get props => [
        chainId,
        mnemonic,
        walletId,
        networkInfo.bech32Hrp,
        networkInfo.lcdUrl,
        networkInfo.name,
        networkInfo.iconUrl,
        networkInfo.defaultTokenDenom,
      ];
}
