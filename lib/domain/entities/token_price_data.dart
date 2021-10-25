import 'package:flutter_app/domain/entities/fiat.dart';
import 'package:flutter_app/domain/entities/token.dart';

class TokenPriceData {
  late List<Token> tokens;
  late List<Fiat> fiats;

  TokenPriceData({required this.tokens, required this.fiats});
}
