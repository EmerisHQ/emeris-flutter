import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';

class VerifiedDenom extends Equatable {
  const VerifiedDenom({
    required this.chainName,
    required this.name,
    required this.denom,
    required this.logo,
    required this.precision,
    required this.verified,
    required this.stakeable,
    required this.ticker,
    required this.feeToken,
    required this.gasPriceLevels,
    required this.fetchPrice,
    required this.relayerDenom,
    required this.minimumThreshRelayerBalance,
  });

  const VerifiedDenom.empty()
      : chainName = '',
        name = '',
        denom = const Denom.empty(),
        logo = '',
        precision = 0,
        verified = false,
        stakeable = false,
        ticker = '',
        feeToken = false,
        gasPriceLevels = const [],
        fetchPrice = false,
        relayerDenom = false,
        minimumThreshRelayerBalance = 0;

  final String chainName;
  final String name;
  final Denom denom;
  final String logo;
  final int precision;
  final bool verified;
  final bool stakeable;
  final String ticker;
  final bool feeToken;
  final List<GasPriceLevel> gasPriceLevels;
  final bool fetchPrice;
  final bool relayerDenom;
  final int minimumThreshRelayerBalance;

  @override
  List<Object?> get props => [
        chainName,
        name,
        denom,
        logo,
        precision,
        verified,
        stakeable,
        ticker,
        feeToken,
        gasPriceLevels,
        fetchPrice,
        relayerDenom,
        minimumThreshRelayerBalance,
      ];

  VerifiedDenom copyWith({
    String? chainName,
    String? name,
    Denom? denom,
    String? logo,
    int? precision,
    bool? verified,
    bool? stakeable,
    String? ticker,
    bool? feeToken,
    List<GasPriceLevel>? gasPriceLevels,
    bool? fetchPrice,
    bool? relayerDenom,
    int? minimumThreshRelayerBalance,
  }) {
    return VerifiedDenom(
      chainName: chainName ?? this.chainName,
      name: name ?? this.name,
      denom: denom ?? this.denom,
      logo: logo ?? this.logo,
      precision: precision ?? this.precision,
      verified: verified ?? this.verified,
      stakeable: stakeable ?? this.stakeable,
      ticker: ticker ?? this.ticker,
      feeToken: feeToken ?? this.feeToken,
      gasPriceLevels: gasPriceLevels ?? this.gasPriceLevels,
      fetchPrice: fetchPrice ?? this.fetchPrice,
      relayerDenom: relayerDenom ?? this.relayerDenom,
      minimumThreshRelayerBalance: minimumThreshRelayerBalance ?? this.minimumThreshRelayerBalance,
    );
  }

  String amountWithDenomText(Amount amount) => Balance(
        denom: denom,
        amount: amount,
      ).amountWithDenomText;
}
