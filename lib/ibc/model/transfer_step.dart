import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/ibc/model/fee_with_denom.dart';

class TransferStep {
  final String name;
  final String status;
  final TransferStepData data;
  final bool addFee;
  final List<FeeWithDenom> feeToAdd;

  TransferStep({
    this.addFee = false,
    this.feeToAdd = const [],
    required this.name,
    required this.status,
    required this.data,
  });
}

class TransferStepData {
  final String toAddress;
  final String chainId;
  final List<FeeWithDenom> chainFee;
  final Balance balance;
  final Denom baseDenom;
  final String fromChain;
  final String toChain;
  final String through;

  TransferStepData({
    required this.balance,
    this.toAddress = '',
    this.chainId = '',
    this.chainFee = const [],
    this.baseDenom = const Denom(''),
    this.fromChain = '',
    this.through = '',
    this.toChain = '',
  });
}
