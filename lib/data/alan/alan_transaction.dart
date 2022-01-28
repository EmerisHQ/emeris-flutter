import 'package:flutter_app/data/alan/messages/alan_send_money_message.dart';
import 'package:flutter_app/domain/entities/send_money_message.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

UnsignedAlanTransaction? alanFromDomain(Transaction transaction) {
  switch (transaction.transactionType) {
    case TransactionType.sendMoney:
      final messages = transaction.messages
          .whereType<SendMoneyMessage>()
          .map(
            AlanMsgSend.fromDomain,
          )
          .toList();
      return UnsignedAlanTransaction(messages: messages, memo: transaction.memo);
  }
}
