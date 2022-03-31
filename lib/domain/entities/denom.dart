import 'package:cosmos_utils/amount_formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';

class Denom extends Equatable {
  const Denom({
    required this.id,
    this.displayName = '',
  });

  const Denom.id(this.id) : displayName = id;

  const Denom.empty()
      : id = '',
        displayName = '';

  final String displayName;
  final String id;

  @override
  List<Object> get props => [
        id,
      ];

  @override
  String toString() => '$displayName($id)';

  String amountWithDenomText(Amount amount) => '${formatAmount(amount.value.toDouble(), symbol: '')} $displayName';
}
