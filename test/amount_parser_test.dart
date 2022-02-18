import 'package:flutter_app/data/utils/amount_parser.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Native chain amount should be parsed correctly', () {
    const amount = '1234uatom';
    const baseDenomText = 'uatom';
    const parsedAmount = '1234';

    expect(parseEmerisAmount(amount, baseDenomText), Amount.fromString(parsedAmount));
  });

  test('Pooled chain amount should be parsed correctly', () {
    const amount = '110445606864ibc/14F9BC3E44B8A9C1BE1FB08980FAB87034C9905EF17CF2F5008FC085218811CC';
    const baseDenomText = 'uosmo';
    const parsedAmount = '110445606864';

    expect(parseEmerisAmount(amount, baseDenomText), Amount.fromString(parsedAmount));
  });
}
