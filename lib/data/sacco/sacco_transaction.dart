import 'package:emeris_app/data/sacco/messages/sacco_send_money_message.dart';
import 'package:emeris_app/domain/entities/send_money_message.dart';
import 'package:emeris_app/domain/entities/transaction.dart';
import 'package:sacco/sacco.dart' as sacco;
import 'package:transaction_signing_gateway/model/signed_transaction.dart';
import 'package:transaction_signing_gateway/model/unsigned_transaction.dart';

class SaccoTransaction implements UnsignedTransaction, SignedTransaction {
  final sacco.StdTx stdTx;

  SaccoTransaction(this.stdTx);

  static SaccoTransaction? fromDomain(Transaction transaction) {
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
}
