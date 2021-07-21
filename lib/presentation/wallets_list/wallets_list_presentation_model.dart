import 'package:emeris_app/data/model/emeris_wallet.dart';
import 'package:emeris_app/domain/stores/wallets_store.dart';
import 'package:emeris_app/presentation/wallets_list/wallets_list_initial_params.dart';

abstract class WalletsListViewModel {
  bool get isEmpty;

  List<EmerisWallet> get wallets;
}

class WalletsListPresentationModel with WalletsListPresentationModelBase implements WalletsListViewModel {
  final WalletsListInitialParams initialParams;
  final WalletsStore _walletsStore;

  WalletsListPresentationModel(this._walletsStore, this.initialParams);

  @override
  bool get isEmpty => wallets.isEmpty;

  @override
  List<EmerisWallet> get wallets => _walletsStore.wallets;
}

//////////////////BOILERPLATE
abstract class WalletsListPresentationModelBase {}
