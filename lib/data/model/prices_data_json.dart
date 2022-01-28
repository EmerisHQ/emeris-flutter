import 'package:flutter_app/data/model/token_price_data_json.dart';

class PricesDataJson {
  const PricesDataJson({
    required this.data,
    required this.message,
    required this.status,
  });

  factory PricesDataJson.fromJson(Map<String, dynamic> json) {
    return PricesDataJson(
      data: json['data'] == null ? null : TokenPriceDataJson.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String? ?? '',
      status: json['status'] as int? ?? -1,
    );
  }

  final TokenPriceDataJson? data;
  final String message;
  final int status;
}
