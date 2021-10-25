import 'package:flutter_app/data/model/ibc_json.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/price.dart';

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

  Balance toDomain(BalanceJson balance, Price prices, List<VerifiedDenomJson> verifiedDenomJson) {
    final amount = Amount.fromString(balance.amount.replaceAll(balance.baseDenom, ''));
    final baseDenomDisplayText =
        verifiedDenomJson.firstWhere((element) => element.name == balance.baseDenom).displayName;
    final ticker = '${verifiedDenomJson.firstWhere((element) => element.name == balance.baseDenom).ticker}USDT';
    final unitPrice = prices.data.tokens.firstWhere((element) => element.denom.text == ticker).amount.value;
    final dollarPrice = amount.value * unitPrice;

    return Balance(
      denom: Denom(baseDenomDisplayText),
      amount: amount,
      unitPrice: Amount.fromString(unitPrice.toStringAsFixed(2)),
      dollarPrice: Amount.fromString(dollarPrice.toStringAsFixed(2)),
    );
  }
}
