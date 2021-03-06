import 'package:cosmos_utils/extensions.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:mobx/mobx.dart';

class BlockchainMetadataStore extends _BlockchainMetadataStoreBase {
  List<VerifiedDenom> get denoms => _denoms.value;

  Prices get prices => _prices.value;

  List<Chain> get chains => _chains.value;

  VerifiedDenom? verifiedDenom(Denom denom) => denoms.firstOrNull(where: (it) => it.name == denom.id);

  Chain? chainForName(String name) => chains.firstOrNull(where: (it) => it.chainName == name);

  Chain? chainForAddress(AccountAddress address) => chains.firstOrNull(
        where: (it) => address.value.startsWith(it.nodeInfo.bech32Config.prefixAccount),
      );
}

abstract class _BlockchainMetadataStoreBase {
  //////////////////////////////////////
  final Observable<Prices> _prices = Observable(const Prices.empty());

  set prices(Prices value) => Action(() => _prices.value = value)();

  //////////////////////////////////////
  final Observable<List<Chain>> _chains = Observable([]);

  set chains(List<Chain> value) => Action(() => _chains.value = value)();

  //////////////////////////////////////
  final Observable<List<VerifiedDenom>> _denoms = Observable([]);

  set denoms(List<VerifiedDenom> value) => Action(() => _denoms.value = value)();
}
