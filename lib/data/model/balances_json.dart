import 'package:flutter_app/data/model/ibc_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class BalanceJson {
  late String address;
  late String baseDenom;
  late bool verified;
  late String amount;
  late String onChain;
  late IbcJson ibc;

  BalanceJson({
    required this.address,
    required this.baseDenom,
    required this.verified,
    required this.amount,
    required this.onChain,
    required this.ibc,
  });

  BalanceJson.fromJson(Map<String, dynamic> json) {
    address = json['address'] as String? ?? '';
    baseDenom = json['base_denom'] as String? ?? '';
    verified = json['verified'] as bool? ?? false;
    amount = json['amount'] as String? ?? '';
    onChain = json['on_chain'] as String? ?? '';
    if (json['ibc'] != null) {
      ibc = IbcJson.fromJson(json['ibc'] as Map<String, dynamic>);
    }
  }

  Balance toDomain(BalanceJson balance) => Balance(
        denom: Denom(balance.baseDenom),
        amount: Amount.fromString(balance.amount.replaceAll(balance.baseDenom, '')),
      );
}
