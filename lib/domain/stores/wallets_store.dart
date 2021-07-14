import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:mobx/mobx.dart';

class WalletsStore with _WalletStoreBase {
  ObservableList<EmerisWallet> get wallets => _wallets.value;

  EmerisWallet? get currentWallet => _currentWallet.value;
}

abstract class _WalletStoreBase {
  //////////////////////////////////////
  final Observable<ObservableList<EmerisWallet>> _wallets = Observable(ObservableList());

  set wallets(ObservableList<EmerisWallet> value) => Action(() => _wallets.value = value)();

  //////////////////////////////////////
  final Observable<EmerisWallet?> _currentWallet = Observable(null);

  set currentWallet(EmerisWallet? value) => Action(() => _currentWallet.value = value)();
}
