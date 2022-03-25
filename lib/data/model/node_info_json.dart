import 'package:flutter_app/data/model/bech_32_config_json.dart';
import 'package:flutter_app/domain/entities/bech_32_config.dart';
import 'package:flutter_app/domain/entities/node_info.dart';

class NodeInfoJson {
  NodeInfoJson({
    required this.endpoint,
    required this.chainId,
    required this.bech32Config,
  });

  factory NodeInfoJson.fromJson(Map<String, dynamic> json) => NodeInfoJson(
        endpoint: json['endpoint'] as String? ?? '',
        chainId: json['chain_id'] as String? ?? '',
        bech32Config: json['bech32_config'] == null
            ? null
            : Bech32ConfigJson.fromJson(json['bech32_config'] as Map<String, dynamic>),
      );

  final String? endpoint;
  final String? chainId;
  final Bech32ConfigJson? bech32Config;

  NodeInfo toDomain() => NodeInfo(
        endpoint: endpoint ?? '',
        chainId: chainId ?? '',
        bech32Config: bech32Config?.toDomain() ?? const Bech32Config.empty(),
      );
}
