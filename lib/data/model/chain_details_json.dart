import 'package:flutter_app/domain/entities/chain.dart';

class ChainDetailsJson {
  ChainDetailsJson({
    required this.chainName,
    required this.displayName,
    required this.logo,
  });

  factory ChainDetailsJson.fromJson(Map<String, dynamic> json) => ChainDetailsJson(
        chainName: json['chain_name'] as String? ?? '',
        logo: json['logo'] as String? ?? '',
        displayName: json['display_name'] as String? ?? '',
      );

  final String chainName;
  final String logo;
  final String displayName;

  Chain toBalanceDomain() => Chain(
        chainName: chainName,
        displayName: displayName,
        logo: logo,
      );
}
