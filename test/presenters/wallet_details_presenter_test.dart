import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_initial_params.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late AccountDetailsInitialParams initParams;
  late AccountDetailsPresentationModel model;
  late AccountDetailsPresenter presenter;
  late AccountDetailsNavigator navigator;
  late MockAccountsStore accountsStore;
  late MockBlockchainMetadataStore blockchainMetadataStore;
  late MockGetBalancesUseCase getBalancesUseCase;
  late EmerisAccount myAccount;
  late Balance balance;
  const fromAddress = 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav';

  void _initMvp() {
    initParams = const AccountDetailsInitialParams();
    model = AccountDetailsPresentationModel(
      initParams,
      accountsStore,
      blockchainMetadataStore,
    );
    navigator = MockAccountDetailsNavigator();
    presenter = AccountDetailsPresenter(
      model,
      navigator,
      getBalancesUseCase,
    );
  }

  test(
    'Getting balances should fill the model data from inside the presentationModel',
    () async {
      // GIVEN
      _initMvp();
      expect(model.balances.isEmpty, true);
      // WHEN
      await presenter.getAccountBalances(myAccount);
      //
      //THEN
      verify(
        () => getBalancesUseCase.execute(
          accountData: myAccount,
        ),
      );
      expect(
        model.balances.first,
        balance,
      );
    },
  );

  setUp(() {
    registerFallbackValue(DisplayableFailure.commonError());
    registerFallbackValue(const AccountDetailsInitialParams());
    accountsStore = MockAccountsStore();
    blockchainMetadataStore = MockBlockchainMetadataStore();
    getBalancesUseCase = MockGetBalancesUseCase();
    balance = Balance(
      denom: const Denom('ATOM'),
      amount: Amount.fromInt(100),
    );
    myAccount = const EmerisAccount(
      accountDetails: AccountDetails(
        accountIdentifier: AccountIdentifier(
          accountId: 'accountId',
          chainId: 'cosmos',
        ),
        accountAlias: 'Name of the account',
        accountAddress: fromAddress,
      ),
      accountType: AccountType.Cosmos,
    );
    when(
      () => getBalancesUseCase.execute(
        accountData: myAccount,
      ),
    ).thenAnswer(
      (_) => successFuture(
        [balance],
      ),
    );
  });
}
