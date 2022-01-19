import 'package:cosmos_utils/amount_formatter.dart';
import 'package:flutter_app/domain/entities/amount.dart';

String formatEmerisAmount(Amount amount, {String symbol = r'$'}) => formatAmount(
      amount.value.toDouble(),
      symbol: symbol,
    );
