import 'package:flutter_app/data/sacco/sacco_credentials_serializer.dart';
import 'package:flutter_app/data/sacco/sacco_private_wallet_credentials.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sacco/sacco.dart' as sacco;

void main() {
  group("Sacco Serializer tests", () {
    final serializer = SaccoCredentialsSerializer();
    final credentials = SaccoPrivateWalletCredentials(
      chainId: "chainId",
      mnemonic: "mnemonic",
      walletId: "walletId",
      networkInfo: sacco.NetworkInfo(
        bech32Hrp: "bech32Hrp",
        lcdUrl: Uri.parse("https://google.com/"),
        name: "name",
        iconUrl: "iconUrl",
        defaultTokenDenom: "defaultTokenDenom",
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
