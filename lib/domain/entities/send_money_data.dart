import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';

class SendMoneyData extends Equatable {
  final WalletType walletType;
  final String denom;
  final String amount;
  final String toAddress;
  final String fromAddress;

  const SendMoneyData({
    required this.amount,
    required this.denom,
    required this.walletType,
    required this.fromAddress,
    required this.toAddress,
  });

  @override
  List<Object> get props => [
        amount,
        denom,
        walletType,
        fromAddress,
        toAddress,
      ];
}
