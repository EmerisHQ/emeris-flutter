import 'package:flutter_app/data/model/denom_json.dart';
import 'package:flutter_app/data/model/gas_price_levels_json.dart';

class VerifiedDenomJson extends DenomJson {
  late String chainName;

  VerifiedDenomJson({
    required String name,
    required String displayName,
    required String logo,
    required int precision,
    required bool verified,
    required bool stakable,
    required String ticker,
    required bool feeToken,
    required GasPriceLevelsJson gasPriceLevels,
    required bool fetchPrice,
    required bool relayerDenom,
    required int minimumThreshRelayerBalance,
    required this.chainName,
  }) : super(
          name: name,
          displayName: displayName,
          feeToken: feeToken,
          fetchPrice: fetchPrice,
          gasPriceLevels: gasPriceLevels,
          logo: logo,
          minimumThreshRelayerBalance: minimumThreshRelayerBalance,
          precision: precision,
          relayerDenom: relayerDenom,
          stakable: stakable,
          ticker: ticker,
          verified: verified,
        );

  VerifiedDenomJson.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    chainName = json['chain_name'] as String;
  }
}
