import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/bech_32_config.dart';

class NodeInfo extends Equatable {
  const NodeInfo({
    required this.endpoint,
    required this.chainId,
    required this.bech32Config,
  });

  const NodeInfo.empty()
      : endpoint = '',
        chainId = '',
        bech32Config = const Bech32Config.empty();

  final String endpoint;
  final String chainId;
  final Bech32Config bech32Config;

  @override
  List<Object?> get props => [
        endpoint,
        chainId,
        bech32Config,
      ];
}
