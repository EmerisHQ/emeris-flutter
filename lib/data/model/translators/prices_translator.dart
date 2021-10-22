import 'package:flutter_app/data/model/prices_data_json.dart';
import 'package:flutter_app/domain/entities/prices.dart';

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
