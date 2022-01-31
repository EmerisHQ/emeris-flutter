import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class AssetDetails extends Equatable {
  const AssetDetails({required this.balances});

  final List<Balance> balances;

  Amount get totalAmountInUSD =>
      Amount(balances.isEmpty ? Decimal.zero : balances.map((it) => it.dollarPrice.value).reduce((a, b) => a + b));

  @override
  List<Object?> get props => [balances, totalAmountInUSD];
}
