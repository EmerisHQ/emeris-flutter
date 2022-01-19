import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/presentation/routing/routing_initial_params.dart';

abstract class RoutingViewModel {}

class RoutingPresentationModel with RoutingPresentationModelBase implements RoutingViewModel {
  final WalletsStore _walletsStore;
  final RoutingInitialParams _initialParams;

  RoutingPresentationModel(this._initialParams, this._walletsStore);

  List<EmerisWallet> get wallets => _walletsStore.wallets;

  bool get initializeApp => _initialParams.initializeApp;
}

//////////////////BOILERPLATE
abstract class RoutingPresentationModelBase {}
