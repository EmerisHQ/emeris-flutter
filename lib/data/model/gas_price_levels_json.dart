import 'package:flutter_app/domain/entities/gas_price_levels.dart';

class GasPriceLevelsJson {
  GasPriceLevelsJson({required this.low, required this.average, required this.high});

  factory GasPriceLevelsJson.fromJson(Map<String, dynamic> json) => GasPriceLevelsJson(
        low: double.tryParse(json['low'].toString()) ?? 0.0,
        average: double.tryParse(json['average'].toString()) ?? 0.0,
        high: double.tryParse(json['high'].toString()) ?? 0.0,
      );

  final double low;
  final double average;
  final double high;

  GasPriceLevels toDomain() => GasPriceLevels(low: low, average: average, high: high);
}
