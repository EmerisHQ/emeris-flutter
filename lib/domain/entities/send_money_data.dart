import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class SendMoneyData extends Equatable {
  final WalletType walletType;
  final Denom denom;
  final Amount amount;
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
