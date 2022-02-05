import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/staking_balance.dart';

class StakingBalanceJson {
  StakingBalanceJson({
    required this.validatorAddress,
    required this.amount,
    required this.chainName,
  });

  factory StakingBalanceJson.fromJson(Map<String, dynamic> json) => StakingBalanceJson(
        validatorAddress: json['validator_address'] as String? ?? '',
        amount: json['amount'] as String? ?? '',
        chainName: json['chain_name'] as String? ?? '',
      );

  StakingBalance toDomain() => StakingBalance(
        validatorAddress: validatorAddress ?? '',
        amount: Amount.fromString(amount ?? '0'),
        chainName: chainName ?? '',
      );

  final String? validatorAddress;
  final String? amount;
  final String? chainName;
}
