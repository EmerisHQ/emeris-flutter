import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/gas_price_levels.dart';

class ChainDenom extends Equatable {
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

  @override
  List<Object?> get props => [
        name,
        displayName,
        logo,
        Element.pre(),
        verified,
        stakable,
        ticker,
        feeToken,
        gasPriceLevels,
        fetchPrice,
        relayerDenom,
        minimumThreshRelayerBalance,
      ];
}
