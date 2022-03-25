import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/node_info.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

class Chain extends Equatable {
  const Chain({
    required this.logo,
    required this.chainName,
    required this.displayName,
    required this.primaryChannel,
    required this.denoms,
    required this.enabled,
    required this.nodeInfo,
  });

  const Chain.empty()
      : logo = '',
        chainName = '',
        displayName = '',
        primaryChannel = const {},
        enabled = false,
        denoms = const [],
        nodeInfo = const NodeInfo.empty();

  final bool? enabled;
  final String chainName;
  final String logo;
  final String displayName;
  final Map<String, String> primaryChannel;
  final List<VerifiedDenom> denoms;
  final NodeInfo nodeInfo;

  @override
  List<Object?> get props => [
        logo,
        chainName,
        displayName,
        primaryChannel,
        denoms,
        enabled,
        nodeInfo,
      ];
}
