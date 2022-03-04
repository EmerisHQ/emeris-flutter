import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class Amount extends Equatable {
  const Amount(this.value);

  Amount.fromString(String string) : value = Decimal.parse(string);

  Amount.fromInt(int int) : value = Decimal.fromInt(int);

  Amount.fromNum(num num) : value = Decimal.parse(num.toString());

  static Amount? tryParse(String string) {
    final value = Decimal.tryParse(string);
    return value == null ? null : Amount(value);
  }

  static final zero = Amount(Decimal.zero);
  static final one = Amount(Decimal.one);

  final Decimal value;

  @override
  String toString() => value.toString();

  String get displayText => value.toString();

  static bool validate(String text) {
    try {
      Amount.fromString(text);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Amount operator *(Amount other) => Amount(value * other.value);

  Amount operator /(Amount other) => Amount(value / other.value);

  Amount operator +(Amount other) => Amount(value + other.value);

  @override
  List<Object?> get props => [
        value,
      ];
}

extension StringAmount on String {
  Amount get amount => Amount.fromString(this);
}

extension IntAmount on int {
  Amount get amount => Amount.fromInt(this);
}
