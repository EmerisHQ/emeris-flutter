import 'package:decimal/decimal.dart';
import 'package:flutter_app/domain/entities/amount.dart';

Amount parseEmerisAmount(String amount, String baseDenom, {int? precision}) => getAmountWithPrecision(
      Amount.fromString(amount.replaceAll(baseDenom, '').split('ibc/')[0]),
      precision ?? 0,
    );

Amount getAmountWithPrecision(Amount amount, int precision) => Amount(
      amount.value / Decimal.fromInt(10).pow(precision),
    );
