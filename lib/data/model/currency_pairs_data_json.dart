import 'package:flutter_app/data/model/fiat_json.dart';
import 'package:flutter_app/data/model/token_pair_json.dart';

class CurrencyPairsDataJson {
  const CurrencyPairsDataJson({required this.tokens, required this.fiats});

  factory CurrencyPairsDataJson.fromJson(Map<String, dynamic> json) {
    return CurrencyPairsDataJson(
      tokens: (json['Tokens'] as List?) //
              ?.map((e) => CurrencyPairJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      fiats: (json['Fiats'] as List?) //
              ?.map((e) => FiatJson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  final List<CurrencyPairJson>? tokens;
  final List<FiatJson>? fiats;
}
