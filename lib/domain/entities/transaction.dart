import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/domain/entities/transaction_message.dart';

enum TransactionType {
  sendMoney,
}

class Transaction extends Equatable {
  const Transaction({
    required this.accountType,
    required this.messages,
    required this.transactionType,
    this.memo = '',
  });

  final AccountType accountType;
  final TransactionType transactionType;
  final List<TransactionMessage> messages;
  final String memo;

  @override
  List<Object> get props => [
        accountType,
        messages,
        transactionType,
        memo,
      ];
}
