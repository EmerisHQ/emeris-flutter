import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:wallet_core/wallet_core.dart';

void main() {
  test(
    'Ethereum test',
    () async {
      final rng = Random.secure();
      final privateKey = Web3.privateKeyFromMnemonic(
        'tiny kitchen artefact label morning axis disorder buffalo fiscal keen valid taxi',
      );
      final privateEthCredentials = EthPrivateKey.fromHex(privateKey);
      final account = Wallet.createNew(privateEthCredentials, 'Hello', rng);
      debugPrint(account.toJson());

//      const apiUrl = "HTTP://127.0.0.1:7545"; // localhost
      const apiUrl = 'https://ropsten.infura.io/v3/96ac5dcb92d545b6a7ffc3d8af21fde0'; // publicly hosted

      final httpClient = Client();
      final ethClient = Web3Client(apiUrl, httpClient);

      final balance = await ethClient.getBalance(
        EthereumAddress.fromHex(account.privateKey.address.hex),
      );

      debugPrint(account.privateKey.address.hex);
      debugPrint(privateEthCredentials.address.hex);
      debugPrint('${balance.getValueInUnit(EtherUnit.ether)}');
      await ethClient.sendTransaction(
        privateEthCredentials,
        Transaction(
          to: EthereumAddress.fromHex('0xf44b768c75438a4e9e0c461d49832799f77245a8'),
          gasPrice: EtherAmount.inWei(BigInt.one),
          maxGas: 100000,
          value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 10),
        ),
      );
    },
    skip: true,
  );
}
