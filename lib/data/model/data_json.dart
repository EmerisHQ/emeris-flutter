import 'package:flutter_app/data/model/fiats_json.dart';
import 'package:flutter_app/data/model/tokens_json.dart';

class DataJson {
  late List<TokensJson> tokens;
  late List<FiatsJson> fiats;

  DataJson({required this.tokens, required this.fiats});

  DataJson.fromJson(Map<String, dynamic> json) {
    if (json['Tokens'] != null) {
      tokens = <TokensJson>[];
      json['Tokens'].forEach((v) {
        tokens.add(TokensJson.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['Fiats'] != null) {
      fiats = <FiatsJson>[];
      json['Fiats'].forEach((v) {
        fiats.add(FiatsJson.fromJson(v as Map<String, dynamic>));
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
