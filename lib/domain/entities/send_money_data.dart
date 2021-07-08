import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class SendMoneyData extends Equatable {
  final WalletType walletType;
  final Balance balance;
  final String toAddress;
  final String fromAddress;

  const SendMoneyData({
    required this.balance,
    required this.walletType,
    required this.fromAddress,
    required this.toAddress,
  });

  @override
  List<Object> get props => [
        balance,
        walletType,
        fromAddress,
        toAddress,
      ];
}
