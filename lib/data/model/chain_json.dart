import 'package:flutter_app/data/model/denom_json.dart';
import 'package:flutter_app/data/model/node_info_json.dart';
import 'package:flutter_app/data/model/primary_channel_chain_json.dart';

class ChainJson {
  late bool enabled;
  late String chainName;
  late String logo;
  late String displayName;
  late PrimaryChannelChainJson primaryChannel;
  late List<DenomJson> denoms;
  late List<String> demerisAddresses;
  late String genesisHash;
  late NodeInfoJson nodeInfo;
  late String validBlockThresh;
  late String derivationPath;
  late String blockExplorer;

  ChainJson({
    required this.enabled,
    required this.chainName,
    required this.displayName,
    required this.primaryChannel,
    required this.denoms,
    required this.demerisAddresses,
    required this.genesisHash,
    required this.nodeInfo,
    required this.validBlockThresh,
    required this.derivationPath,
    required this.blockExplorer,
  });

  ChainJson.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'] as bool? ?? false;
    chainName = json['chain_name'] as String? ?? '';
    logo = json['logo'] as String? ?? '';
    displayName = json['display_name'] as String? ?? '';
    if (json['primary_channel'] != null) {
      primaryChannel = PrimaryChannelChainJson.fromJson(json['primary_channel'] as Map<String, dynamic>);
    }
    if (json['denoms'] != null) {
      denoms = <DenomJson>[];
      json['denoms'].forEach((v) {
        denoms.add(DenomJson.fromJson(v as Map<String, dynamic>));
      });
    }
    demerisAddresses = (json['demeris_addresses'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    genesisHash = json['genesis_hash'] as String? ?? '';
    if (json['node_info'] != null) {
      nodeInfo = NodeInfoJson.fromJson(json['node_info'] as Map<String, dynamic>);
    }
    validBlockThresh = json['valid_block_thresh'] as String? ?? '';
    derivationPath = json['derivation_path'] as String? ?? '';
    blockExplorer = json['block_explorer'] as String? ?? '';
  }
}
