import 'package:flutter_app/domain/entities/pool.dart';

class PoolJson {
  PoolJson({
    required this.id,
    required this.typeId,
    required this.reserveCoinDenoms,
    required this.reserveAccountAddress,
    required this.poolCoinDenom,
  });

  final String id;
  final int typeId;
  final List<String> reserveCoinDenoms;
  final String reserveAccountAddress;
  final String poolCoinDenom;

  factory PoolJson.fromJson(Map<String, dynamic> json) => PoolJson(
        id: json["id"] as String? ?? '',
        typeId: json["type_id"] as int? ?? 0,
        reserveCoinDenoms: (json['reserve_coin_denoms'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        reserveAccountAddress: json["reserve_account_address"] as String? ?? '',
        poolCoinDenom: json["pool_coin_denom"] as String? ?? '',
      );

  Pool toBalanceDomain() => Pool(
        id: id,
        typeId: typeId,
        reserveCoinDenoms: reserveCoinDenoms,
        reserveAccountAddress: reserveAccountAddress,
        poolCoinDenom: poolCoinDenom,
      );
}
