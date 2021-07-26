import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';

abstract class RoutingViewModel {}

class RoutingPresentationModel with RoutingPresentationModelBase implements RoutingViewModel {
  final WalletsStore _walletsStore;

  RoutingPresentationModel(this._walletsStore);

  List<EmerisWallet> get wallets => _walletsStore.wallets;
}

//////////////////BOILERPLATE
abstract class RoutingPresentationModelBase {}
