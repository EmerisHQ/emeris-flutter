import 'package:flutter_app/domain/entities/gas_price_level.dart';

class GasPriceLevelsJson {
  late double low;
  late double average;
  late double high;

  GasPriceLevelsJson({required this.low, required this.average, required this.high});

  GasPriceLevelsJson.fromJson(Map<String, dynamic> json) {
    low = double.tryParse(json['low'].toString()) ?? 0.0;
    average = double.tryParse(json['average'].toString()) ?? 0.0;
    high = double.tryParse(json['high'].toString()) ?? 0.0;
  }

  GasPriceLevel toDomain() => GasPriceLevel(low: low, average: average, high: high);
}
