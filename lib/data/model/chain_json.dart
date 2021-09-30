import 'package:flutter_app/data/model/denom_json.dart';
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

class Bech32ConfigJson {
  late String mainPrefix;
  late String prefixAccount;
  late String prefixValidator;
  late String prefixConsensus;
  late String prefixPublic;
  late String prefixOperator;
  late String accAddr;
  late String accPub;
  late String valAddr;
  late String valPub;
  late String consAddr;
  late String consPub;

  Bech32ConfigJson({
    required this.mainPrefix,
    required this.prefixAccount,
    required this.prefixValidator,
    required this.prefixConsensus,
    required this.prefixPublic,
    required this.prefixOperator,
    required this.accAddr,
    required this.accPub,
    required this.valAddr,
    required this.valPub,
    required this.consAddr,
    required this.consPub,
  });

  Bech32ConfigJson.fromJson(Map<String, dynamic> json) {
    mainPrefix = json['main_prefix'] as String? ?? '';
    prefixAccount = json['prefix_account'] as String? ?? '';
    prefixValidator = json['prefix_validator'] as String? ?? '';
    prefixConsensus = json['prefix_consensus'] as String? ?? '';
    prefixPublic = json['prefix_public'] as String? ?? '';
    prefixOperator = json['prefix_operator'] as String? ?? '';
    accAddr = json['acc_addr'] as String? ?? '';
    accPub = json['acc_pub'] as String? ?? '';
    valAddr = json['val_addr'] as String? ?? '';
    valPub = json['val_pub'] as String? ?? '';
    consAddr = json['cons_addr'] as String? ?? '';
    consPub = json['cons_pub'] as String? ?? '';
  }
}
