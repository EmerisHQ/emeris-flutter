import 'package:cosmos_utils/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/fiat.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';

class Prices extends Equatable {
  const Prices({
    required this.tokens,
    required this.fiats,
  });

  const Prices.empty()
      : tokens = const [],
        fiats = const [];

  final List<TokenPair> tokens;
  final List<FiatPair> fiats;

  @override
  List<Object?> get props => [
        tokens,
        fiats,
      ];

  TokenPair? priceForDenom(Denom denom) => tokens //
      .firstOrNull(where: (it) => it.ticker.startsWith(denom.displayName) || it.ticker.startsWith(denom.id));

  String totalPriceText(Balance balance) => balance.totalPriceText(
        priceForDenom(balance.denom) ?? TokenPair.zero(balance.denom),
      );
}
