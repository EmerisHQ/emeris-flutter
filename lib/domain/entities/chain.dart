import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/chain_denom.dart';

class Chain extends Equatable {
  const Chain({
    required this.logo,
    required this.chainName,
    required this.displayName,
    required this.primaryChannel,
    this.enabled,
    this.denoms,
  });

  const Chain.empty()
      : logo = '',
        chainName = '',
        displayName = '',
        primaryChannel = const {},
        enabled = null,
        denoms = null;

  final bool? enabled;
  final String chainName;
  final String logo;
  final String displayName;
  final Map<String, String> primaryChannel;
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
