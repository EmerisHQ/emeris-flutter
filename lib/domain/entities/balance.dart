import 'package:cosmos_utils/extensions.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

class Balance extends Equatable {
  Balance({
    required this.denom,
    required this.amount,
    this.onChain = '',
    Amount? unitPrice,
    Amount? dollarPrice,
  })  : unitPrice = unitPrice ?? Amount.zero,
        dollarPrice = dollarPrice ?? Amount.zero;

  Balance.empty()
      : denom = const Denom(''),
        amount = Amount.zero,
        unitPrice = Amount.zero,
        dollarPrice = Amount.zero,
        onChain = '';

  Balance copyWith({
    Denom? denom,
    Amount? amount,
    String? onChain,
    Amount? unitPrice,
    Amount? dollarPrice,
  }) =>
      Balance(
        denom: denom ?? this.denom,
        amount: amount ?? this.amount,
        onChain: onChain ?? this.onChain,
        unitPrice: unitPrice ?? this.unitPrice,
        dollarPrice: dollarPrice ?? this.dollarPrice,
      );

  final Denom denom;
  final Amount amount;
  final Amount unitPrice;
  final Amount dollarPrice;
  final String onChain;

  @override
  String toString() {
    return '$amount $denom';
  }

  @override
  List<Object> get props => [
        denom,
        amount,
        unitPrice,
        dollarPrice,
      ];

  Balance byUpdatingPriceAndVerifiedDenom(Price price, List<VerifiedDenom> verifiedDenoms) {
    final baseDenomDisplayText = verifiedDenoms.firstWhere((element) => element.name == denom.text).displayName;
    final ticker = '${verifiedDenoms.firstWhere((element) => element.name == denom.text).ticker}USDT';

    /// TODO: Pick up the pool token prices from the API or calculate it as done in the web
    final unitPrice =
        price.data.tokens.firstOrNull(where: (it) => it.denom.text == ticker)?.amount.value ?? Decimal.zero;
    final dollarPrice = amount.value * unitPrice;

    return Balance(
      denom: Denom(baseDenomDisplayText),
      amount: amount,
      unitPrice: Amount.fromString(unitPrice.toStringAsFixed(2)),
      dollarPrice: Amount.fromString(dollarPrice.toStringAsFixed(2)),
      onChain: onChain,
    );
  }
}

extension TotalAmount on Iterable<Balance> {
  Amount get totalAmount => Amount(
        map((it) => it.amount.value).reduce((a, b) => a + b),
      );
}
