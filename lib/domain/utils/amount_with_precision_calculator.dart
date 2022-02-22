import 'package:decimal/decimal.dart';
import 'package:flutter_app/domain/entities/amount.dart';

Amount getAmountWithPrecision(Amount amount, int precision) => Amount(
      amount.value / Decimal.fromInt(10).pow(precision),
    );
