import 'package:decimal/decimal.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';
import 'package:flutter_app/domain/entities/gas_price_level_type.dart';

class GasPriceLevelsJson {
  GasPriceLevelsJson({required this.low, required this.average, required this.high});

  factory GasPriceLevelsJson.fromJson(Map<String, dynamic> json) => GasPriceLevelsJson(
        low: Decimal.tryParse(json['low'].toString()) ?? Decimal.zero,
        average: Decimal.tryParse(json['average'].toString()) ?? Decimal.zero,
        high: Decimal.tryParse(json['high'].toString()) ?? Decimal.zero,
      );

  final Decimal low;
  final Decimal average;
  final Decimal high;

  List<GasPriceLevel> toDomain({required Denom denom}) => [
        low.toGasPriceLevel(GasPriceLevelType.low, denom),
        average.toGasPriceLevel(GasPriceLevelType.average, denom),
        high.toGasPriceLevel(GasPriceLevelType.high, denom),
      ];
}

extension GasPriceLevelDecimal on Decimal {
  GasPriceLevel toGasPriceLevel(
    GasPriceLevelType type,
    Denom denom,
  ) =>
      GasPriceLevel(
        type: type,
        balance: Balance(
          denom: denom,
          amount: Amount(this),
        ),
      );
}
