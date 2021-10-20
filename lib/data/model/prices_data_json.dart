import 'package:flutter_app/data/model/data_json.dart';
import 'package:flutter_app/domain/entities/prices.dart';

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

  PricesDomain toDomain(PricesDataJson model) {
    return PricesDomain(
      data: DataDomain(
        fiats: model.data.fiats.map((e) => FiatsDomain(symbol: e.symbol, price: e.price)).toList(),
        tokens: model.data.tokens.map((e) => TokensDomain(symbol: e.symbol, price: e.price, supply: e.supply)).toList(),
      ),
      message: model.message,
      status: model.status,
    );
  }
}
