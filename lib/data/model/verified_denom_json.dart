import 'package:flutter_app/data/model/gas_price_levels_json.dart';

class VerifiedDenomJson {
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
  late String chainName;

  VerifiedDenomJson(
      {required this.name,
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
      required this.chainName});

  VerifiedDenomJson.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String? ?? '';
    displayName = json['display_name'] as String? ?? '';
    logo = json['logo'] as String? ?? '';
    precision = json['precision'] as int? ?? -1;
    verified = json['verified'] as bool;
    stakable = json['stakable'] as bool? ?? false;
    ticker = json['ticker'] as String? ?? '';
    feeToken = json['fee_token'] as bool? ?? false;
    if (json['gas_price_levels'] != null) {
      gasPriceLevels = GasPriceLevelsJson.fromJson(json['gas_price_levels'] as Map<String, dynamic>);
    }
    fetchPrice = json['fetch_price'] as bool;
    relayerDenom = json['relayer_denom'] as bool;
    minimumThreshRelayerBalance = json['minimum_thresh_relayer_balance'] as int? ?? -1;
    chainName = json['chain_name'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['display_name'] = displayName;
    data['logo'] = logo;
    data['precision'] = precision;
    data['verified'] = verified;
    data['stakable'] = stakable;
    data['ticker'] = ticker;
    data['fee_token'] = feeToken;
    data['gas_price_levels'] = gasPriceLevels.toJson();
    data['fetch_price'] = fetchPrice;
    data['relayer_denom'] = relayerDenom;
    data['minimum_thresh_relayer_balance'] = minimumThreshRelayerBalance;
    data['chain_name'] = chainName;
    return data;
  }
}
