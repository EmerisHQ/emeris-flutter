import 'package:cosmos_ui_components/models/account_info.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/use_cases/change_current_account_use_case.dart';
import 'package:flutter_app/domain/use_cases/delete_account_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_account/add_account_initial_params.dart';
import 'package:flutter_app/ui/pages/import_account/import_account_initial_params.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';

class AccountsListPresenter {
  AccountsListPresenter(
    this._model,
    this.navigator,
    this._changeCurrentAccountUseCase,
    this._deleteAccountUseCase,
  );

  final AccountsListPresentationModel _model;
  final AccountsListNavigator navigator;
  final ChangeCurrentAccountUseCase _changeCurrentAccountUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  AccountsListViewModel get viewModel => _model;

  Future<void> addAccountClicked() async => showNotImplemented();

  void accountClicked(EmerisAccount account) {
    _changeCurrentAccountUseCase.execute(account: account).observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => doNothing(),
        );
    navigator.close();
  }

  void editClicked() => _model.isEditingAccountList = !_model.isEditingAccountList;

  void onTapImportAccount() => navigator.openImportAccount(const ImportAccountInitialParams());

  void onTapCreateAccount() => navigator.openAddAccount(const AddAccountInitialParams());

  void onTapClose() => navigator.close();

  void onTapEditAccount(AccountInfo account) => navigator.openEditAccountSheet(
        title: account.name,
        onTapDelete: () => _deleteAccount(account),
      );

  Future<void> _deleteAccount(AccountInfo account) async {
    final passcode = await navigator.openPasscode(const PasscodeInitialParams());
    if (passcode == null) {
      return navigator.close();
    }
    await _deleteAccountUseCase
        .execute(
      account: _model.accounts.firstWhere((it) => it.accountDetails.accountAddress.value == account.address),
      passcode: passcode,
    )
        .map(
      (isAccountsListEmpty) {
        if (isAccountsListEmpty) {
          navigator.openRouting(const RoutingInitialParams());
        } else {
          navigator.close();
        }
        return right(true);
      },
    );
  }
}
