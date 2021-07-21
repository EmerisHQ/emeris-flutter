import 'dart:typed_data';

import 'package:emeris_app/domain/entities/send_money_message.dart';
import 'package:emeris_app/domain/entities/transaction.dart';
import 'package:transaction_signing_gateway/model/signed_transaction.dart';
import 'package:transaction_signing_gateway/model/unsigned_transaction.dart';
import 'package:web3dart/web3dart.dart' as eth;

class EthereumTransaction implements UnsignedTransaction {
  final eth.Transaction unsignedTransaction;

  EthereumTransaction(this.unsignedTransaction);

  static EthereumTransaction? fromDomain(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.sendMoney:
        final message = transaction.messages.whereType<SendMoneyMessage>().toList().first;
        return EthereumTransaction(
          eth.Transaction(
            to: eth.EthereumAddress.fromHex(message.toAddress),
            gasPrice: eth.EtherAmount.inWei(BigInt.one),
            maxGas: 100000,
            value: eth.EtherAmount.fromUnitAndValue(
              eth.EtherUnit.ether,
              message.balance.amount,
            ),
          ),
        );
    }
  }
}

class EthereumSignedTransaction implements SignedTransaction {
  final Uint8List txBytes;

  EthereumSignedTransaction(this.txBytes);
}
