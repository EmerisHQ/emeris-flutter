import 'package:flutter_app/data/model/prices_data_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/fiat.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/token_price_data.dart';
import 'package:flutter_app/domain/entities/token.dart';

/// TODO: Update [Price]
/// The domain needs to be updated according to what the UI requires,
/// stuff like converted USD values, and per unit price values of the assets.
extension PricesTranslator on PricesDataJson {
  Price toPrices() {
    return Price(
      data: TokenPriceData(
        fiats: data.fiats.map((e) => Fiat(symbol: e.symbol, price: e.price)).toList(),
        tokens: data.tokens
            .map(
              (e) => Token(
                denom: Denom(e.symbol),
                amount: Amount.fromString(e.price.toStringAsFixed(2)),
                supply: e.supply,
              ),
            )
            .toList(),
      ),
      message: message,
      status: status,
    );
  }
}
