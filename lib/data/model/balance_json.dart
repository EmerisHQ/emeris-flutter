import 'package:flutter_app/data/model/ibc_json.dart';
import 'package:flutter_app/data/utils/amount_parser.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

class BalanceJson {
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
        ibc: json['ibc'] == null ? null : IbcJson.fromJson(json['ibc'] as Map<String, dynamic>),
      );

  final String? address;
  final String? baseDenom;
  final bool? verified;
  final String? amount;
  final String? onChain;
  final IbcJson? ibc;

  Balance toDomain(VerifiedDenom verifiedDenom) => Balance(
        amount: parseEmerisAmount(
          amount ?? '0',
          baseDenom ?? '',
          precision: verifiedDenom.precision,
        ),
        denom: verifiedDenom.denom.id.isEmpty //
            ? Denom.id(baseDenom ?? '')
            : verifiedDenom.denom,
        onChain: onChain ?? '',
      );
}
