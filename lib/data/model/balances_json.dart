import 'package:flutter_app/data/model/ibc_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class BalanceJson {
  final String address;
  final String baseDenom;
  final bool verified;
  final String amount;
  final String onChain;
  final IbcJson ibc;

  BalanceJson({
    required this.address,
    required this.baseDenom,
    required this.verified,
    required this.amount,
    required this.onChain,
    required this.ibc,
  });

  factory BalanceJson.fromJson(Map<String, dynamic> json) => BalanceJson(
        address: json['address'] as String? ?? '',
        baseDenom: json['base_denom'] as String? ?? '',
        verified: json['verified'] as bool? ?? false,
        amount: json['amount'] as String? ?? '',
        onChain: json['on_chain'] as String? ?? '',
        ibc: IbcJson.fromJson(json['ibc'] as Map<String, dynamic>),
      );

  Balance toBalanceDomain() =>
      Balance(amount: Amount.fromString(amount.replaceAll(baseDenom, '')), denom: Denom(baseDenom));
}
