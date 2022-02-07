import 'package:flutter_app/data/model/denom_json.dart';
import 'package:flutter_app/data/model/node_info_json.dart';
import 'package:flutter_app/domain/entities/chain.dart';

class ChainJson {
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
    required this.logo,
  });

  factory ChainJson.fromJson(Map<String, dynamic> json) => ChainJson(
        enabled: json['enabled'] as bool? ?? false,
        chainName: json['chain_name'] as String? ?? '',
        logo: json['logo'] as String? ?? '',
        displayName: json['display_name'] as String? ?? '',
        primaryChannel: (json['primary_channel'] as Map<String, String>).cast(),
        denoms: (json['denoms'] as List?)?.map((v) => DenomJson.fromJson(v as Map<String, dynamic>)).toList() ?? [],
        demerisAddresses: (json['demeris_addresses'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        genesisHash: json['genesis_hash'] as String? ?? '',
        nodeInfo: json['node_info'] == null ? null : NodeInfoJson.fromJson(json['node_info'] as Map<String, dynamic>),
        validBlockThresh: json['valid_block_thresh'] as String? ?? '',
        derivationPath: json['derivation_path'] as String? ?? '',
        blockExplorer: json['block_explorer'] as String? ?? '',
      );

  final bool? enabled;
  final String? chainName;
  final String? logo;
  final String? displayName;
  final Map<String, String>? primaryChannel;
  final List<DenomJson>? denoms;
  final List<String>? demerisAddresses;
  final String? genesisHash;
  final NodeInfoJson? nodeInfo;
  final String? validBlockThresh;
  final String? derivationPath;
  final String? blockExplorer;

  Chain toDomain() => Chain(
        enabled: enabled,
        chainName: chainName ?? '',
        displayName: displayName ?? '',
        primaryChannel: primaryChannel ?? {},
        denoms: denoms?.map((it) => it.toDomain()).toList(),
        logo: logo ?? '',
      );
}
