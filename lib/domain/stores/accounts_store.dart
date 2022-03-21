import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:mobx/mobx.dart';

class AccountsStore with _AccountStoreBase {
  ObservableList<EmerisAccount> get accounts => _accounts.value;

  EmerisAccount get currentAccount => _currentAccount.value ?? const EmerisAccount.empty();

  void addAccount(EmerisAccount account) => Action(() {
        accounts.add(account);
      })();

  void updateAccount({
    required AccountIdentifier identifier,
    required EmerisAccount account,
  }) =>
      Action(() {
        final index = accounts.indexWhere((element) => element.accountDetails.accountIdentifier == identifier);
        if (index != -1) {
          accounts[index] = account;
        }
        if(identifier == currentAccount.accountDetails.accountIdentifier) {
          currentAccount = account;
        }
      })();

  void removeAccount(EmerisAccount account) => Action(() {
        accounts.remove(account);
      })();

  void addAllAccounts(List<EmerisAccount> newAccounts) => Action(() {
        accounts.addAll(newAccounts);
      })();

  ReactionDisposer listenToAccountChanges(ValueChanged<EmerisAccount> callback) => reaction(
        (_) => currentAccount,
        callback,
      );
}

mixin _AccountStoreBase {
  //////////////////////////////////////
  final Observable<ObservableList<EmerisAccount>> _accounts = Observable(ObservableList());

  set accounts(ObservableList<EmerisAccount> value) => Action(() => _accounts.value = value)();

  //////////////////////////////////////
  final Observable<EmerisAccount?> _currentAccount = Observable(null);

  set currentAccount(EmerisAccount value) => Action(() => _currentAccount.value = value)();
}
