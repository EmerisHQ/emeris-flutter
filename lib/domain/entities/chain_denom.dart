import 'package:flutter_app/domain/entities/gas_price_levels.dart';

class ChainDenom {
  ChainDenom({
    required this.name,
    required this.displayName,
    required this.logo,
    required this.precision,
    required this.verified,
    required this.stakable,
    required this.ticker,
    required this.feeToken,
    required this.gasPriceLevels,
    required this.fetchPrice,
    required this.relayerDenom,
    required this.minimumThreshRelayerBalance,
  });

  final String name;
  final String displayName;
  final String logo;
  final int precision;
  final bool verified;
  final bool stakable;
  final String ticker;
  final bool feeToken;
  final GasPriceLevels gasPriceLevels;
  final bool fetchPrice;
  final bool relayerDenom;
  final int minimumThreshRelayerBalance;
}
