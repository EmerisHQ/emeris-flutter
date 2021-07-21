import 'package:equatable/equatable.dart';
import 'package:emeris_app/data/model/wallet_type.dart';
import 'package:emeris_app/domain/entities/transaction_message.dart';

enum TransactionType {
  sendMoney,
}

class Transaction extends Equatable {
  final WalletType walletType;
  final TransactionType transactionType;
  final List<TransactionMessage> messages;

  const Transaction({
    required this.walletType,
    required this.messages,
    required this.transactionType,
  });

  @override
  List<Object> get props => [
        walletType,
        messages,
        transactionType,
      ];
}
