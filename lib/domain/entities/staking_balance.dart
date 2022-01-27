import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';

class StakingBalance extends Equatable {
  final String validatorAddress;
  final Amount amount;
  final String chainName;

  const StakingBalance({
    required this.validatorAddress,
    required this.amount,
    required this.chainName,
  });

  @override
  List<Object> get props => [validatorAddress, amount, chainName];
}
