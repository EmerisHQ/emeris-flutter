import 'package:emeris_app/data/sacco/sacco_credentials_serializer.dart';
import 'package:emeris_app/data/sacco/sacco_private_wallet_credentials.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sacco/sacco.dart' as sacco;
import 'package:transaction_signing_gateway/model/wallet_public_info.dart';

void main() {
  group("Sacco Serializer tests", () {
    final serializer = SaccoCredentialsSerializer();
    final credentials = SaccoPrivateWalletCredentials(
      mnemonic: "mnemonic",
      networkInfo: sacco.NetworkInfo(
        bech32Hrp: "bech32Hrp",
        lcdUrl: Uri.parse("https://google.com/"),
        name: "name",
        iconUrl: "iconUrl",
        defaultTokenDenom: "defaultTokenDenom",
      ),
      publicInfo: const WalletPublicInfo(
        chainId: "chainId",
        walletId: "walletId",
        name: 'name',
        publicAddress: 'cosmos124maqmcqv8tquy764ktz7cu0gxnzfw54k9cmz5',
      ),
    );

    test("serializes and deserializes correctly", () {
      final jsonResult = serializer.toJson(credentials);
      expect(jsonResult.isRight(), true);
      final credentialsResult = jsonResult.flatMap((json) => serializer.fromJson(json));
      expect(credentialsResult.isRight(), true);
      expect(credentialsResult.getOrElse(() => throw ""), credentials);
    });
  });
}
