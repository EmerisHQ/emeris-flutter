import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class AssetDetails extends Equatable {
  final List<Balance> balances;

  Amount get totalAmountInUSD => Amount(balances.map((it) => it.dollarPrice.value).reduce((a, b) => a + b));

  const AssetDetails({required this.balances});

  @override
  List<Object?> get props => [balances, totalAmountInUSD];
}
