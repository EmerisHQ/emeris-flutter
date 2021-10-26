import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class AssetDetails extends Equatable {
  final List<Balance> balances;

  Amount get totalAmountInUSD => Amount.fromString(_calculateTotalAmount().toStringAsFixed(2));

  const AssetDetails({required this.balances});

  @override
  List<Object?> get props => [balances, totalAmountInUSD];

  double _calculateTotalAmount() {
    var totalAmount = 0.0;
    for (final element in balances) {
      totalAmount += element.dollarPrice.value.toDouble();
    }
    return totalAmount;
  }
}
