import 'package:flutter_app/data/utils/amount_parser.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Correct precision should be calculated for balances', () {
    expect(
      getAmountWithPrecision(Amount.fromString('123456789'), 0),
      Amount.fromString('123456789'),
    );

    expect(
      getAmountWithPrecision(Amount.fromString('123456789'), 6),
      Amount.fromString('123.456789'),
    );

    expect(
      getAmountWithPrecision(Amount.fromString('1234567.89'), 18),
      Amount.fromString('0.00000000000123456789'),
    );

    expect(
      getAmountWithPrecision(Amount.fromString('12345678943256456'), 24),
      Amount.fromString('0.000000012345678943256456'),
    );

    expect(
      getAmountWithPrecision(Amount.fromString('123456789'), 36),
      Amount.fromString('0.000000000000000000000000000123456789'),
    );
  });
}
