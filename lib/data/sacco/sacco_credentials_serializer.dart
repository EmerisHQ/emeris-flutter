import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/sacco/sacco_private_wallet_credentials.dart';
import 'package:flutter_app/utils/logger.dart';
import 'package:sacco/sacco.dart' as sacco;
import 'package:transaction_signing_gateway/model/credentials_storage_failure.dart';
import 'package:transaction_signing_gateway/model/private_wallet_credentials.dart';
import 'package:transaction_signing_gateway/model/private_wallet_credentials_serializer.dart';

class SaccoCredentialsSerializer implements PrivateWalletCredentialsSerializer {
  static const id = "SaccoCredentialsSerializer";

  static const chainIdKey = "chain_id";
  static const mnemonicKey = "mnemonic";
  static const networkInfoKey = "networkInfo";
  static const walletIdKey = "walletId";

  static const bech32HrpKey = "bech32Hrp";
  static const lcdUrlKey = "lcdUrl";
  static const nameKey = "name";
  static const iconUrlKey = "iconUrl";
  static const defaultTokenDenomKey = "defaultTokenDenom";

  @override
  Either<CredentialsStorageFailure, PrivateWalletCredentials> fromJson(Map<String, dynamic> json) {
    try {
      return right(SaccoPrivateWalletCredentials(
        chainId: json[chainIdKey] as String? ?? "",
        mnemonic: json[mnemonicKey] as String? ?? "",
        walletId: json[walletIdKey] as String? ?? "",
        networkInfo: sacco.NetworkInfo(
          bech32Hrp: json[networkInfoKey][bech32HrpKey] as String? ?? "",
          lcdUrl: Uri.parse(json[networkInfoKey][lcdUrlKey] as String? ?? ""),
          name: json[networkInfoKey][nameKey] as String? ?? "",
          iconUrl: json[networkInfoKey][iconUrlKey] as String? ?? "",
          defaultTokenDenom: json[networkInfoKey][defaultTokenDenomKey] as String? ?? "",
        ),
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
    if (credentials is! SaccoPrivateWalletCredentials) {
      return left(CredentialsStorageFailure(
          "Passed credentials are not of type $SaccoPrivateWalletCredentials. actual: $credentials"));
    }
    return right({
      chainIdKey: credentials.chainId,
      walletIdKey: credentials.walletId,
      mnemonicKey: credentials.mnemonic,
      networkInfoKey: {
        bech32HrpKey: credentials.networkInfo.bech32Hrp,
        lcdUrlKey: credentials.networkInfo.lcdUrl.toString(),
        nameKey: credentials.networkInfo.name,
        iconUrlKey: credentials.networkInfo.iconUrl,
        defaultTokenDenomKey: credentials.networkInfo.defaultTokenDenom,
      },
    });
  }
}
