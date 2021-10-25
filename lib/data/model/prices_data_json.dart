import 'package:flutter_app/data/model/token_price_data_json.dart';

class PricesDataJson {
  late TokenPriceDataJson data;
  dynamic message;
  late int status;

  PricesDataJson({required this.data, required this.message, required this.status});

  PricesDataJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = TokenPriceDataJson.fromJson(json['data'] as Map<String, dynamic>);
    }
    message = json['message'];
    status = json['status'] as int? ?? -1;
  }
}
