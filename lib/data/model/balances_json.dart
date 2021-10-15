import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class BalanceJson {
  late String address;
  late String baseDenom;
  late bool verified;
  late String amount;
  late String onChain;
  late Ibc ibc;

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
      ibc = Ibc.fromJson(json['ibc'] as Map<String, dynamic>);
    }
  }

  List<Balance> toDomain(List<BalanceJson> balances) => balances
      .where((element) => element.verified)
      .map(
        (it) => Balance(
          denom: Denom(it.baseDenom),
          amount: Amount.fromString(it.amount.replaceAll(it.baseDenom, '')),
        ),
      )
      .toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['base_denom'] = baseDenom;
    data['verified'] = verified;
    data['amount'] = amount;
    data['on_chain'] = onChain;
    data['ibc'] = ibc.toJson();
    return data;
  }
}

class Ibc {
  late String path;
  late String hash;

  Ibc({required this.path, required this.hash});

  Ibc.fromJson(Map<String, dynamic> json) {
    path = json['path'] as String? ?? '';
    hash = json['hash'] as String? ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['path'] = path;
    data['hash'] = hash;
    return data;
  }
}
