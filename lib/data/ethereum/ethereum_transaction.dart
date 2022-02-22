import 'dart:typed_data';

import 'package:flutter_app/domain/entities/send_tokens_form_data.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:transaction_signing_gateway/model/signed_transaction.dart';
import 'package:transaction_signing_gateway/model/unsigned_transaction.dart';
import 'package:web3dart/web3dart.dart' as eth;

class EthereumTransaction implements UnsignedTransaction {
  EthereumTransaction(this.unsignedTransaction);

  final eth.Transaction unsignedTransaction;

  static EthereumTransaction? fromDomain(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.sendMoney:
        final message = transaction.messages.whereType<SendTokensFormData>().toList().first;
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
  EthereumSignedTransaction(this.txBytes);

  final Uint8List txBytes;
}
