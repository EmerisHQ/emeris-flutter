import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:mobx/mobx.dart';

class WalletsStore with _WalletStoreBase {
  ObservableList<EmerisWallet> get wallets => _wallets.value;

  EmerisWallet get currentWallet => _currentWallet.value ?? const EmerisWallet.empty();

  void addWallet(EmerisWallet wallet) => Action(() {
        wallets.add(wallet);
      })();

  void removeWallet(EmerisWallet wallet) => Action(() {
        wallets.remove(wallet);
      })();

  void addAllWallets(List<EmerisWallet> newWallets) => Action(() {
        wallets.addAll(newWallets);
      })();

  ReactionDisposer listenToWalletChanges(ValueChanged<EmerisWallet> callback) => reaction(
        (_) => currentWallet,
        callback,
      );
}

mixin _WalletStoreBase {
  //////////////////////////////////////
  final Observable<ObservableList<EmerisWallet>> _wallets = Observable(ObservableList());

  set wallets(ObservableList<EmerisWallet> value) => Action(() => _wallets.value = value)();

  //////////////////////////////////////
  final Observable<EmerisWallet?> _currentWallet = Observable(null);

  set currentWallet(EmerisWallet value) => Action(() => _currentWallet.value = value)();
}
