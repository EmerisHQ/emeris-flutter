import 'package:flutter_app/data/model/gas_price_levels_json.dart';

class DenomJson {
  final String name;
  final String displayName;
  final String logo;
  final int precision;
  final bool verified;
  final bool stakable;
  final String ticker;
  final bool feeToken;
  final GasPriceLevelsJson? gasPriceLevels;
  final bool fetchPrice;
  final bool relayerDenom;
  final int minimumThreshRelayerBalance;

  DenomJson({
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

  factory DenomJson.fromJson(Map<String, dynamic> json) => DenomJson(
        name: json['name'] as String? ?? '',
        displayName: json['display_name'] as String? ?? '',
        logo: json['logo'] as String? ?? '',
        precision: json['precision'] as int? ?? -1,
        verified: json['verified'] as bool? ?? false,
        stakable: json['stakable'] as bool? ?? false,
        ticker: json['ticker'] as String? ?? '',
        feeToken: json['fee_token'] as bool? ?? false,
        gasPriceLevels: json['gas_price_levels'] == null
            ? null
            : GasPriceLevelsJson.fromJson(json['gas_price_levels'] as Map<String, dynamic>),
        fetchPrice: json['fetch_price'] as bool? ?? false,
        relayerDenom: json['relayer_denom'] as bool? ?? false,
        minimumThreshRelayerBalance: json['minimum_thresh_relayer_balance'] as int? ?? -1,
      );
}
