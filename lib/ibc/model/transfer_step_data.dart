import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/ibc/model/fee_with_denom.dart';

class TransferStepData {
  TransferStepData({
    required this.balance,
    this.toAddress = '',
    this.chainId = '',
    this.chainFee = const [],
    this.baseDenom = const Denom.id(''),
    this.fromChain = '',
    this.through = '',
    this.toChain = '',
  });

  final String toAddress;
  final String chainId;
  final List<FeeWithDenom> chainFee;
  final Balance balance;
  final Denom baseDenom;
  final String fromChain;
  final String toChain;
  final String through;
}
