import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_initial_params.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_navigator.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_presenter.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late AccountsListSheet page;
  late AccountsListInitialParams initParams;
  late AccountsListPresentationModel model;
  late AccountsListPresenter presenter;
  late AccountsListNavigator navigator;
  final list = mobx.ObservableList<EmerisAccount>();

  void _initMvp() {
    list.addAll([
      const EmerisAccount.empty().copyWith(
        accountDetails: const AccountDetails(
          accountIdentifier: AccountIdentifier.empty(),
          accountAlias: 'Hello',
          accountAddress: AccountAddress(value: 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav'),
        ),
      )
    ]);
    initParams = const AccountsListInitialParams();
    model = AccountsListPresentationModel(initParams, Mocks.accountsStore);
    navigator = AccountsListNavigator(Mocks.appNavigator);
    presenter = AccountsListPresenter(
      model,
      navigator,
      Mocks.changeCurrentAccountUseCase,
      Mocks.deleteAccountUseCase,
    );
    page = AccountsListSheet(presenter: presenter);
  }

  screenshotTest(
    'account_list_sheet',
    setUp: () {
      _initMvp();
      when(() => Mocks.accountsStore.accounts).thenAnswer((invocation) => list);
      when(() => Mocks.accountsStore.currentAccount).thenAnswer((invocation) => const EmerisAccount.empty());
    },
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  screenshotTest(
    'account_list_sheet_empty',
    setUp: () {
      _initMvp();
      when(() => Mocks.accountsStore.accounts).thenAnswer((invocation) => mobx.ObservableList());
      when(() => Mocks.accountsStore.currentAccount).thenAnswer((invocation) => const EmerisAccount.empty());
    },
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  test(
    'getIt page resolves successfully',
    () async {
      expect(getIt<AccountsListSheet>(param1: _MockAccountsListInitialParams()), isNotNull);
    },
  );
}

class _MockAccountsListInitialParams extends Mock implements AccountsListInitialParams {}
