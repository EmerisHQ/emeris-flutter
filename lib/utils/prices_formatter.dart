import 'package:cosmos_utils/amount_formatter.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';

@Deprecated('use [formatTokenPrice] wherever possible')
String formatEmerisAmount(Amount amount, {String symbol = r'$'}) => formatAmount(
      amount.value.toDouble(),
      symbol: symbol,
    );

String formatTokenPrice(Amount amount, TokenPair tokenPair) => formatEmerisAmount(
      amount * tokenPair.unitPrice,
      symbol: tokenPair.ticker.endsWith('USDT') ? r'$' : '',
    );
