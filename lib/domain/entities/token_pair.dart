import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class TokenPair extends Equatable {
  const TokenPair({
    required this.ticker,
    required this.unitPrice,
    required this.supply,
  });

  TokenPair.zero([Denom? denom])
      : ticker = '${(denom ?? const Denom.empty()).text}USDT',
        unitPrice = Amount.one,
        supply = Amount.zero;

  final String ticker;
  final Amount unitPrice;
  final Amount? supply;

  @override
  List<Object?> get props => [
        ticker,
        unitPrice,
        supply,
      ];

  Amount totalPriceAmount(Amount amount) => amount * unitPrice;
}
