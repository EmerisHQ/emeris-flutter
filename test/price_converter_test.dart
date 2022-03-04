import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/utils/price_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TokenPair tokenPair;
  late PriceConverter priceConverter;

  test('should show valid amounts for "token" type', () async {
    // GIVEN
    priceConverter.primaryText = '10.50';
    // THEN
    expect(
      priceConverter.primaryAmount,
      Amount.fromString('10.50'),
    );
    expect(
      priceConverter.secondaryAmount,
      Amount.fromString('319.935'),
    );
  });

  test('switching type should retain the value of tokens', () async {
    // GIVEN
    priceConverter
      ..primaryText = '10.50'
      //WHEN
      ..primaryAmountType = PriceType.fiat;
    // THEN
    expect(
      priceConverter.primaryAmount,
      Amount.fromString('319.935'),
    );
    expect(
      priceConverter.primaryText,
      '319.935',
    );
    expect(
      priceConverter.secondaryAmount,
      Amount.fromString('10.50'),
    );
  });

  test('should format secondary text for "token" type', () async {
    // GIVEN
    priceConverter..primaryText = '10.50';
    // THEN
    expect(
      priceConverter.secondaryPriceText,
      r'$319.94',
    );
  });

  test('should format secondary text for "fiat" type', () async {
    // GIVEN
    priceConverter
      ..primaryText = '10.50'
      ..primaryAmountType = PriceType.fiat;
    // THEN
    expect(
      priceConverter.secondaryPriceText,
      '10.5 ATOM',
    );
  });

  test('should format primary text for "token" type', () async {
    // GIVEN
    priceConverter
      ..primaryText = '10.50'
      ..primaryAmountType = PriceType.fiat;
    // THEN
    expect(
      priceConverter.secondaryPriceText,
      '10.5 ATOM',
    );
  });

  test('should format primary text for "fiat" type', () async {
    // GIVEN
    priceConverter..primaryText = '10.50';
    // THEN
    expect(
      priceConverter.secondaryPriceText,
      r'$319.94',
    );
  });

  setUp(() {
    tokenPair = TokenPair(
      ticker: 'ATOMUSDT',
      unitPrice: Amount.fromString('30.47'),
      supply: Amount.zero,
    );
    priceConverter = PriceConverter(
      tokenPair,
      const Denom('ATOM'),
    );
  });
}
