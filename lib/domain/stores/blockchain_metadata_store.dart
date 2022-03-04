import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:mobx/mobx.dart';

class BlockchainMetadataStore extends _BlockchainMetadataStoreBase {
  List<VerifiedDenom> get denoms => _denoms.value;

  Prices get prices => _prices.value;

  List<Chain> get chains => _chains.value;
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
