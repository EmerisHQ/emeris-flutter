import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class AccountsListViewModel {
  bool get isEmpty;

  bool get isEditingAccountList;

  List<EmerisAccount> get accounts;

  EmerisAccount get selectedAccount;
}

class AccountsListPresentationModel with AccountsListPresentationModelBase implements AccountsListViewModel {
  AccountsListPresentationModel(this._accountsStore, this.initialParams);

  final AccountsListInitialParams initialParams;
  final AccountsStore _accountsStore;

  @override
  bool get isEmpty => accounts.isEmpty;

  @override
  List<EmerisAccount> get accounts => _accountsStore.accounts;

  @override
  EmerisAccount get selectedAccount => _accountsStore.currentAccount;

  @override
  bool get isEditingAccountList => _isEditingAccountList.value;
}

//////////////////BOILERPLATE
mixin AccountsListPresentationModelBase {
  final Observable<bool> _isEditingAccountList = Observable(false);

  set isEditingAccountList(bool value) => Action(() => _isEditingAccountList.value = value)();
}
