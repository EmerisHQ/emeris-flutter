import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class WalletsListViewModel {
  bool get isEmpty;

  bool get isEditingAccountList;

  List<EmerisWallet> get wallets;

  EmerisWallet get selectedWallet;
}

class WalletsListPresentationModel with WalletsListPresentationModelBase implements WalletsListViewModel {
  WalletsListPresentationModel(this._walletsStore, this.initialParams);

  final WalletsListInitialParams initialParams;
  final WalletsStore _walletsStore;

  @override
  bool get isEmpty => wallets.isEmpty;

  @override
  List<EmerisWallet> get wallets => _walletsStore.wallets;

  @override
  EmerisWallet get selectedWallet => _walletsStore.currentWallet ?? _walletsStore.wallets.first;

  @override
  bool get isEditingAccountList => _isEditingAccountList.value;
}

//////////////////BOILERPLATE
mixin WalletsListPresentationModelBase {
  final Observable<bool> _isEditingAccountList = Observable(false);

  set isEditingAccountList(bool value) => Action(() => _isEditingAccountList.value = value)();
}
