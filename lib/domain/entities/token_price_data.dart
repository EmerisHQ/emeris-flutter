import 'package:flutter_app/domain/entities/fiat.dart';
import 'package:flutter_app/domain/entities/token.dart';

class TokenPriceData {
  TokenPriceData({required this.tokens, required this.fiats});

  late List<Token> tokens;
  late List<Fiat> fiats;
}
