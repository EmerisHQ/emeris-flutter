import 'package:flutter_app/data/sacco/messages/sacco_send_money_message.dart';
import 'package:flutter_app/domain/entities/send_money_message.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:sacco/sacco.dart' as sacco;
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

SaccoTransaction? saccoFromfromDomain(Transaction transaction) {
  switch (transaction.transactionType) {
    case TransactionType.sendMoney:
      final messages = transaction.messages
          .whereType<SendMoneyMessage>()
          .map(
            (moneyMessage) => SaccoSendMoneyMessage.fromDomain(moneyMessage).toStdMsg(),
          )
          .toList();
      return SaccoTransaction(sacco.TxBuilder.buildStdTx(stdMsgs: messages));
  }
}
