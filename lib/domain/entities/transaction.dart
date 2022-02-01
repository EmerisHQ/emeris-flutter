import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/transaction_message.dart';

enum TransactionType {
  sendMoney,
}

class Transaction extends Equatable {
  const Transaction({
    required this.walletType,
    required this.messages,
    required this.transactionType,
    this.memo = '',
  });

  final WalletType walletType;
  final TransactionType transactionType;
  final List<TransactionMessage> messages;
  final String memo;

  @override
  List<Object> get props => [
        walletType,
        messages,
        transactionType,
        memo,
      ];
}
