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
}

/// TODO: Update [PricesDomain]
/// The domain needs to be updated according to what the UI requires,
/// stuff like converted USD values, and per unit price values of the assets.
extension PricesTranslator on PricesDataJson {
  PricesDomain toPrices() {
    return PricesDomain(
      data: DataDomain(
        fiats: data.fiats.map((e) => FiatsDomain(symbol: e.symbol, price: e.price)).toList(),
        tokens: data.tokens.map((e) => TokensDomain(symbol: e.symbol, price: e.price, supply: e.supply)).toList(),
      ),
      message: message,
      status: status,
    );
  }
}
