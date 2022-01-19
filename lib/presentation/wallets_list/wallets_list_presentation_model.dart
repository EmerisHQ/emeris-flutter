import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class WalletsListViewModel {
  bool get isEmpty;

  bool get isEditingAccountList;

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

  @override
  bool get isEditingAccountList => _isEditingAccountList.value;
}

//////////////////BOILERPLATE
abstract class WalletsListPresentationModelBase {
  final Observable<bool> _isEditingAccountList = Observable(false);

  set isEditingAccountList(bool value) => Action(() => _isEditingAccountList.value = value)();
}
