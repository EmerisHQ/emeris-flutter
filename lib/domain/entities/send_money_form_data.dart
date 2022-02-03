import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/transaction_message.dart';

class SendMoneyFormData extends Equatable implements TransactionMessage {
  const SendMoneyFormData({
    required this.balance,
    required this.walletType,
    required this.fromAddress,
    required this.toAddress,
  });

  SendMoneyFormData.empty()
      : balance = Balance.empty(),
        walletType = WalletType.Cosmos,
        fromAddress = '',
        toAddress = '';

  final WalletType walletType;
  final Balance balance;
  final String toAddress;
  final String fromAddress;

  @override
  List<Object> get props => [
        balance,
        walletType,
        fromAddress,
        toAddress,
      ];
}
