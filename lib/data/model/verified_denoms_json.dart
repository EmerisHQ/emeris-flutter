class VerifiedDenomsJson {
  late List<VerifiedDenoms> verifiedDenoms;

  VerifiedDenomsJson({required this.verifiedDenoms});

  VerifiedDenomsJson.fromJson(Map<String, dynamic> json) {
    if (json['verified_denoms'] != null) {
      verifiedDenoms = <VerifiedDenoms>[];
      json['verified_denoms'].forEach((v) {
        verifiedDenoms.add(VerifiedDenoms.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['verified_denoms'] = verifiedDenoms.map((v) => v.toJson()).toList();

    return data;
  }
}

class VerifiedDenoms {
  late String name;
  late String displayName;
  late String logo;
  late int precision;
  late bool verified;
  late bool stakable;
  late String ticker;
  late bool feeToken;
  late GasPriceLevels gasPriceLevels;
  late bool fetchPrice;
  late bool relayerDenom;
  late int minimumThreshRelayerBalance;
  late String chainName;

  VerifiedDenoms(
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

  VerifiedDenoms.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String? ?? '';
    displayName = json['display_name'] as String? ?? '';
    logo = json['logo'] as String? ?? '';
    precision = json['precision'] as int? ?? -1;
    verified = json['verified'] as bool;
    stakable = json['stakable'] as bool? ?? false;
    ticker = json['ticker'] as String? ?? '';
    feeToken = json['fee_token'] as bool? ?? false;
    if (json['gas_price_levels'] != null) {
      gasPriceLevels = GasPriceLevels.fromJson(json['gas_price_levels'] as Map<String, dynamic>);
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

class GasPriceLevels {
  late double low;
  late double average;
  late double high;

  GasPriceLevels({required this.low, required this.average, required this.high});

  GasPriceLevels.fromJson(Map<String, dynamic> json) {
    low = double.tryParse(json['low'].toString()) ?? 0.0;
    average = double.tryParse(json['average'].toString()) ?? 0.0;
    high = double.tryParse(json['high'].toString()) ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['low'] = low;
    data['average'] = average;
    data['high'] = high;
    return data;
  }
}
