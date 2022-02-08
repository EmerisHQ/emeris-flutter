import 'package:flutter_app/data/model/fiat_json.dart';
import 'package:flutter_app/data/model/token_json.dart';

class TokenPriceDataJson {
  const TokenPriceDataJson({required this.tokens, required this.fiats});

  factory TokenPriceDataJson.fromJson(Map<String, dynamic> json) {
    return TokenPriceDataJson(
      tokens: (json['Tokens'] as List?)?.map((e) => TokenJson.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      fiats: (json['Fiats'] as List?)?.map((e) => FiatJson.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  final List<TokenJson>? tokens;
  final List<FiatJson>? fiats;
}
