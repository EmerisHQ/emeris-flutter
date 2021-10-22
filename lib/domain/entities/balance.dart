import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class AssetDetails extends Equatable {
  final List<Balance> balances;
  final Amount totalAmountInUSD;

  const AssetDetails({required this.balances, required this.totalAmountInUSD});

  @override
  List<Object?> get props => [balances, totalAmountInUSD];
}

class Balance extends Equatable {
  final Denom denom;
  final Amount amount;
  final Amount unitPrice;
  final Amount dollarPrice;

  const Balance({required this.denom, required this.amount, required this.unitPrice, required this.dollarPrice});

  @override
  String toString() {
    return '$amount $denom';
  }

  @override
  List<Object> get props => [denom, amount, unitPrice, dollarPrice];
}
