import 'package:flutter_app/data/model/prices_data_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/fiat.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';

extension PricesTranslator on PricesDataJson {
  Prices toPrices() {
    return Prices(
      fiats: data?.fiats
              ?.map(
                (e) => FiatPair(
                  ticker: e.symbol ?? '',
                  price: e.price ?? 0,
                ),
              )
              .toList() ??
          [],
      tokens: data?.tokens
              ?.map(
                (e) => TokenPair(
                  ticker: (e.symbol ?? '').toUpperCase(),
                  unitPrice: Amount.fromString(e.price.toString()),
                  supply: Amount.fromNum(e.supply?.toDouble() ?? 0.0),
                ),
              )
              .toList() ??
          [],
    );
  }
}
