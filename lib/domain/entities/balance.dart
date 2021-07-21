import 'package:equatable/equatable.dart';
import 'package:emeris_app/domain/entities/amount.dart';
import 'package:emeris_app/domain/entities/denom.dart';

class Balance extends Equatable {
  final Denom denom;
  final Amount amount;

  const Balance({
    required this.denom,
    required this.amount,
  });

  @override
  String toString() {
    return '$amount $denom';
  }

  @override
  List<Object> get props => [
        denom,
        amount,
      ];
}
