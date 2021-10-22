import 'package:flutter_app/data/model/data_json.dart';

class PricesDataJson {
  late DataJson data;
  dynamic message;
  late int status;

  PricesDataJson({required this.data, required this.message, required this.status});

  PricesDataJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = DataJson.fromJson(json['data'] as Map<String, dynamic>);
    }
    message = json['message'];
    status = json['status'] as int? ?? -1;
  }
}
