import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:flutter/foundation.dart';

/// Only for transferring sample tokens to newly created wallet
Future<void> main() async {
  final networkInfo = NetworkInfo.fromSingleHost(
    bech32Hrp: 'cosmos',
    host: 'localhost',
  );

  const mnemonicString =
      'wasp include bike spare load gossip solution breeze doll drill leisure shell paper now hockey involve purse involve same mesh measure ill cheese endorse';
  final mnemonic = mnemonicString.split(' ');
  final wallet = Wallet.derive(mnemonic, networkInfo);

  // 3. Create and sign the transaction
  final message = bank.MsgSend.create()
    ..fromAddress = wallet.bech32Address
    ..toAddress = 'cosmos1wpmu3sqrnkfddz4vq7v4ks70gyqsxv7z0nepxy';
  message.amount.add(
    Coin.create()
      ..denom = 'stake'
      ..amount = '2',
  );

  final signer = TxSigner.fromNetworkInfo(networkInfo);
  final tx = await signer.createAndSign(wallet, [message]);

  // 4. Broadcast the transaction
  final txSender = TxSender.fromNetworkInfo(networkInfo);
  final response = await txSender.broadcastTx(tx);

  // Check the result
  if (response.isSuccessful) {
    debugPrint('Tx sent successfully. Response: response');
  } else {
    debugPrint('Tx errored: response');
  }
}
