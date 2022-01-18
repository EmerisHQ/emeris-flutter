import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class Token {
  late Denom denom;
  late Amount amount;
  late double supply;

  Token({required this.denom, required this.amount, required this.supply});
}
