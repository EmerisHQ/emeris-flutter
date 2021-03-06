import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_initial_params.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late AccountsListInitialParams initParams;
  late AccountsListPresentationModel model;
  late AccountsListPresenter presenter;
  late AccountsListNavigator navigator;
  late EmerisAccount myAccount;
  const fromAddress = 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav';

  void _initMvp() {
    initParams = const AccountsListInitialParams();
    model = AccountsListPresentationModel(initParams, Mocks.accountsStore);
    navigator = Mocks.accountsListNavigator;
    presenter = AccountsListPresenter(
      model,
      navigator,
      Mocks.changeCurrentAccountUseCase,
      Mocks.deleteAccountUseCase,
    );
  }

  test(
    'Changing the current account should fill the `selectedAccount` inside the presentationModel',
    () async {
      // GIVEN
      _initMvp();
      // WHEN
      presenter.accountClicked(myAccount);
      //
      //THEN
      verify(
        () => Mocks.changeCurrentAccountUseCase.execute(
          account: myAccount,
        ),
      );
      expect(
        model.selectedAccount,
        myAccount,
      );
    },
  );

  setUp(() {
    myAccount = const EmerisAccount(
      accountDetails: AccountDetails(
        accountIdentifier: AccountIdentifier(
          accountId: 'accountId',
          chainId: 'cosmos',
        ),
        accountAlias: 'Name of the account',
        accountAddress: AccountAddress(value: fromAddress),
      ),
      accountType: AccountType.Cosmos,
    );
    when(() => Mocks.accountsStore.currentAccount).thenReturn(myAccount);
    when(() => Mocks.changeCurrentAccountUseCase.execute(account: myAccount)) //
        .thenAnswer((_) => successFuture(unit));
  });
}
