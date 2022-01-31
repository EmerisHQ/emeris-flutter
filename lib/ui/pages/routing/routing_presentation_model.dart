import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';

abstract class RoutingViewModel {}

class RoutingPresentationModel with RoutingPresentationModelBase implements RoutingViewModel {
  RoutingPresentationModel(this._initialParams, this._walletsStore);

  final WalletsStore _walletsStore;
  final RoutingInitialParams _initialParams;

  List<EmerisWallet> get wallets => _walletsStore.wallets;

  bool get initializeApp => _initialParams.initializeApp;
}

//////////////////BOILERPLATE
mixin RoutingPresentationModelBase {}
