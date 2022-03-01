import 'package:flutter_app/domain/entities/prices.dart';
import 'package:mobx/mobx.dart';

class BlockchainMetadataStore extends _BlockchainMetadataStoreBase {
  Prices get prices => _prices.value;
}

abstract class _BlockchainMetadataStoreBase {
  //////////////////////////////////////
  final Observable<Prices> _prices = Observable(const Prices.empty());

  set prices(Prices value) => Action(() => _prices.value = value)();
}
