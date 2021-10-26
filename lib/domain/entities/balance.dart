import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

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

class Balance extends Equatable {
  final Denom denom;
  final Amount amount;
  final Amount unitPrice;
  final Amount dollarPrice;

  Balance({
    required this.denom,
    required this.amount,
    Amount? unitPrice,
    Amount? dollarPrice,
  })  : unitPrice = unitPrice ?? Amount.zero,
        dollarPrice = dollarPrice ?? Amount.zero;

  @override
  String toString() {
    return '$amount $denom';
  }

  @override
  List<Object> get props => [denom, amount, unitPrice, dollarPrice];

  Balance toDomain(Balance balance, Price prices, List<VerifiedDenom> verifiedDenomJson) {
    final baseDenomDisplayText =
        verifiedDenomJson.firstWhere((element) => element.name == balance.denom.text).displayName;
    final ticker = '${verifiedDenomJson.firstWhere((element) => element.name == balance.denom.text).ticker}USDT';
    final unitPrice = prices.data.tokens.firstWhere((element) => element.denom.text == ticker).amount.value;
    final dollarPrice = amount.value * unitPrice;

    return Balance(
      denom: Denom(baseDenomDisplayText),
      amount: amount,
      unitPrice: Amount.fromString(unitPrice.toStringAsFixed(2)),
      dollarPrice: Amount.fromString(dollarPrice.toStringAsFixed(2)),
    );
  }
}
