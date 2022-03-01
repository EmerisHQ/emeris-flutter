import 'package:cosmos_utils/amount_formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/utils/amount_with_precision_calculator.dart';
import 'package:flutter_app/utils/prices_formatter.dart';

class Balance extends Equatable {
  const Balance({
    required this.denom,
    required this.amount,
    this.onChain = '',
  });

  Balance.empty()
      : denom = const Denom.empty(),
        amount = Amount.zero,
        onChain = '';

  final Denom denom;
  final Amount amount;
  final String onChain;

  Amount totalPrice(Prices prices) => prices.priceForDenom(denom)?.totalPriceAmount(amount) ?? Amount.zero;

  @override
  String toString() {
    return '$amount $denom';
  }

  @override
  List<Object> get props => [
        denom,
        amount,
      ];

  Balance byUpdatingPriceAndVerifiedDenom(
    Prices prices,
    List<VerifiedDenom> verifiedDenoms,
  ) {
    final baseDenom = verifiedDenoms.firstWhere((element) => element.name == denom.text);

    /// TODO: Pick up the pool token prices from the API or calculate it as done in the web
    TokenPair.zero(denom);

    return Balance(
      denom: Denom(baseDenom.displayName),
      amount: getAmountWithPrecision(amount, baseDenom.precision),
      onChain: onChain,
    );
  }

  Balance copyWith({
    Denom? denom,
    Amount? amount,
    TokenPair? tokenPrice,
    String? onChain,
  }) {
    return Balance(
      denom: denom ?? this.denom,
      amount: amount ?? this.amount,
      onChain: onChain ?? this.onChain,
    );
  }

  String totalPriceText(Prices prices) => formatTokenPrice(
        amount,
        prices.priceForDenom(denom) ?? TokenPair.zero(denom),
      );

  String unitPriceText(Prices prices) => formatTokenPrice(
        Amount.one,
        prices.priceForDenom(denom) ?? TokenPair.zero(denom),
      );

  /// TODO use 'precision' for determining the format
  String get amountWithDenomText => '${formatAmount(amount.value.toDouble(), symbol: '')} ${denom.text}';
}

extension TotalAmount on Iterable<Balance> {
  Amount get totalAmount => Amount(
        map((it) => it.amount.value).reduce((a, b) => a + b),
      );
}
