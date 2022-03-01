import 'package:cosmos_utils/amount_formatter.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';

String formatTokenPrice(Amount amount, TokenPair tokenPair) {
  return formatAmount(
    (amount * tokenPair.unitPrice).value.toDouble(),
    symbol: tokenPair.symbol,
  );
}
