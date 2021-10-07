import 'package:flutter_app/data/model/gas_price_levels_json.dart';

class DenomJson {
  late String name;
  late String displayName;
  late String logo;
  late int precision;
  late bool verified;
  late bool stakable;
  late String ticker;
  late bool feeToken;
  late GasPriceLevelsJson gasPriceLevels;
  late bool fetchPrice;
  late bool relayerDenom;
  late int minimumThreshRelayerBalance;

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

  DenomJson.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String? ?? '';
    displayName = json['display_name'] as String? ?? '';
    logo = json['logo'] as String? ?? '';
    precision = json['precision'] as int? ?? -1;
    verified = json['verified'] as bool? ?? false;
    stakable = json['stakable'] as bool? ?? false;
    ticker = json['ticker'] as String? ?? '';
    feeToken = json['fee_token'] as bool? ?? false;
    if (json['gas_price_levels'] != null) {
      gasPriceLevels = GasPriceLevelsJson.fromJson(json['gas_price_levels'] as Map<String, dynamic>);
    }
    fetchPrice = json['fetch_price'] as bool? ?? false;
    relayerDenom = json['relayer_denom'] as bool? ?? false;
    minimumThreshRelayerBalance = json['minimum_thresh_relayer_balance'] as int? ?? -1;
  }
}
