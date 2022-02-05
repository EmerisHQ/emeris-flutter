import 'package:flutter_app/data/model/prices_data_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/fiat.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/token.dart';
import 'package:flutter_app/domain/entities/token_price_data.dart';

extension PricesTranslator on PricesDataJson {
  Price toPrices() {
    return Price(
      data: TokenPriceData(
        fiats: data?.fiats.map((e) => Fiat(symbol: e.symbol ?? '', price: e.price ?? 0)).toList() ?? [],
        tokens: data?.tokens
                .map(
                  (e) => Token(
                    denom: Denom(e.symbol),
                    amount: Amount.fromString(e.price.toString()),
                    supply: e.supply.toDouble(),
                  ),
                )
                .toList() ??
            [],
      ),
      message: message,
      status: status ?? 0,
    );
  }
}
