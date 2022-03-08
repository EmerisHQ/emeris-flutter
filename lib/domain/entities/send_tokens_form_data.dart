import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/transaction_message.dart';

class SendTokensFormData extends Equatable implements TransactionMessage {
  const SendTokensFormData({
    required this.balance,
    required this.accountType,
    required this.fromAddress,
    required this.toAddress,
  });

  SendTokensFormData.empty()
      : balance = Balance.empty(),
        accountType = AccountType.Cosmos,
        fromAddress = '',
        toAddress = '';

  final AccountType accountType;
  final Balance balance;
  final String toAddress;
  final String fromAddress;

  @override
  List<Object> get props => [
        balance,
        accountType,
        fromAddress,
        toAddress,
      ];
}
