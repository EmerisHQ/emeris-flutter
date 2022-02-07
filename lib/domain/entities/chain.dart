import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/chain_denom.dart';

class Chain extends Equatable {
  const Chain({
    required this.logo,
    required this.chainName,
    required this.displayName,
    this.enabled,
    this.primaryChannel,
    this.denoms,
  });

  final bool? enabled;
  final String chainName;
  final String logo;
  final String displayName;
  final Map<String, dynamic>? primaryChannel;
  final List<ChainDenom>? denoms;

  @override
  List<Object?> get props => [
        enabled,
        chainName,
        logo,
        displayName,
        primaryChannel,
        denoms,
      ];
}
