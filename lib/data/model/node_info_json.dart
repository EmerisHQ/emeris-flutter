import 'package:flutter_app/data/model/bech_32_config_json.dart';

class NodeInfoJson {
  final String endpoint;
  final String chainId;
  final Bech32ConfigJson bech32Config;

  NodeInfoJson({
    required this.endpoint,
    required this.chainId,
    required this.bech32Config,
  });

  factory NodeInfoJson.fromJson(Map<String, dynamic> json) => NodeInfoJson(
        endpoint: json['endpoint'] as String? ?? '',
        chainId: json['chain_id'] as String? ?? '',
        bech32Config: Bech32ConfigJson.fromJson(json['bech32_config'] as Map<String, dynamic>),
      );
}
