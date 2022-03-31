import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class TransactionFee extends Equatable {
  const TransactionFee({
    required this.amount,
    required this.denom,
  });

  final Amount amount;
  final Denom denom;

  @override
  List<Object> get props => [
        amount,
        denom,
      ];
}
