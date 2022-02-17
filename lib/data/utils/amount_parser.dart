import 'package:flutter_app/domain/entities/amount.dart';

Amount parseEmerisAmount(String amount, String baseDenom) =>
    Amount.fromString(amount.replaceAll(baseDenom, '').split('ibc/')[0]);
