import 'package:flutter_app/domain/entities/chain_denom.dart';
import 'package:flutter_app/domain/entities/primary_channel_chain.dart';

class Chain {
  Chain({
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
  final PrimaryChannelChain? primaryChannel;
  final List<ChainDenom>? denoms;
}
