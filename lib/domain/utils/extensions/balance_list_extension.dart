import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';

extension TotalAmount on Iterable<Balance> {
  Amount get totalAmount => Amount(
        map((it) => it.amount.value).reduce((a, b) => a + b),
      );
}
