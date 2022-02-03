import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class Amount extends Equatable {
  const Amount(this.value);

  Amount.fromString(String string) : value = Decimal.parse(string);

  Amount.fromInt(int int) : value = Decimal.fromInt(int);

  static final zero = Amount(Decimal.zero);

  final Decimal value;

  @override
  String toString() => value.toStringAsPrecision(10);

  String get displayText => value.toStringAsPrecision(10);

  static bool validate(String text) {
    try {
      Amount.fromString(text);
      return true;
    } catch (ex) {
      return false;
    }
  }

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
