import 'package:flutter_app/data/alan/messages/alan_msg_send.dart';
import 'package:flutter_app/domain/entities/send_tokens_form_data.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:transaction_signing_gateway/transaction_signing_gateway.dart';

UnsignedAlanTransaction? alanFromDomain(Transaction transaction) {
  switch (transaction.transactionType) {
    case TransactionType.sendMoney:
      final messages = transaction.messages
          .whereType<SendTokensFormData>()
          .map(
            AlanMsgSend.fromDomain,
          )
          .toList();
      return UnsignedAlanTransaction(
        messages: messages,
        memo: transaction.memo,
      );
  }
}
