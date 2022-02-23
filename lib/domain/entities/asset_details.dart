import 'package:cosmos_utils/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/utils/prices_formatter.dart';

class AssetDetails extends Equatable {
  const AssetDetails({required this.balances});

  final List<Balance> balances;

  Amount totalAmountInUSD(Prices prices) => balances.isEmpty //
      ? Amount.zero
      : balances //
          .map((it) => it.totalPrice(prices))
          .reduce((a, b) => a + b);

  @override
  List<Object?> get props => [
        balances,
      ];

  String totalAmountInUSDText(Prices prices) {
    final balance = balances.firstOrNull();
    if (balance == null) {
      return '';
    }
    final pair = prices.priceForDenom(balance.denom);
    if (pair == null) {
      return '';
    }
    return formatTokenPrice(totalAmountInUSD(prices), pair);
  }
}
