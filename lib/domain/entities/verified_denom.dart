import 'package:flutter_app/domain/entities/gas_price_level.dart';

class VerifiedDenom {
  String chainName;
  String name;
  String displayName;
  String logo;
  int precision;
  bool verified;
  bool stakable;
  String ticker;
  bool feeToken;
  GasPriceLevel gasPriceLevels;
  bool fetchPrice;
  bool relayerDenom;
  int minimumThreshRelayerBalance;

  VerifiedDenom({
    required this.chainName,
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
}
