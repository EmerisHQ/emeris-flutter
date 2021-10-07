import 'package:flutter_app/data/model/bech_32_config_json.dart';

class NodeInfoJson {
  late String endpoint;
  late String chainId;
  late Bech32ConfigJson bech32Config;

  NodeInfoJson({
    required this.endpoint,
    required this.chainId,
    required this.bech32Config,
  });

  NodeInfoJson.fromJson(Map<String, dynamic> json) {
    endpoint = json['endpoint'] as String? ?? '';
    chainId = json['chain_id'] as String? ?? '';
    if (json['bech32_config'] != null) {
      bech32Config = Bech32ConfigJson.fromJson(json['bech32_config'] as Map<String, dynamic>);
    }
  }
}
