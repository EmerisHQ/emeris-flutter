import 'package:flutter_app/data/model/fiat_json.dart';
import 'package:flutter_app/data/model/token_json.dart';

class TokenPriceDataJson {
  late List<TokenJson> tokens;
  late List<FiatJson> fiats;

  TokenPriceDataJson({required this.tokens, required this.fiats});

  TokenPriceDataJson.fromJson(Map<String, dynamic> json) {
    if (json['Tokens'] != null) {
      tokens = <TokenJson>[];
      json['Tokens'].forEach((v) {
        tokens.add(TokenJson.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['Fiats'] != null) {
      fiats = <FiatJson>[];
      json['Fiats'].forEach((v) {
        fiats.add(FiatJson.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Tokens'] = tokens.map((v) => v.toJson()).toList();
    data['Fiats'] = fiats.map((v) => v.toJson()).toList();
    return data;
  }
}
