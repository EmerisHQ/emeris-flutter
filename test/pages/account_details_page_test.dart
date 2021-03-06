import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/fiat.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_initial_params.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_page.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late AccountDetailsPage page;
  late AccountDetailsInitialParams initParams;
  late AccountDetailsPresentationModel model;
  late AccountDetailsPresenter presenter;
  late AccountDetailsNavigator navigator;
  late EmerisAccount myAccount;
  const denom = Denom(id: 'uakt', displayName: 'AKT');
  final verifiedDenom = const VerifiedDenom.empty().copyWith(
    denom: denom,
    precision: 6,
  );

  void _initMvp() {
    myAccount = const EmerisAccount(
      accountDetails: AccountDetails.empty(),
      accountType: AccountType.Cosmos,
    );
    initParams = const AccountDetailsInitialParams();
    model = AccountDetailsPresentationModel(
      initParams,
      Mocks.accountsStore,
      Mocks.blockchainMetadataStore,
      Mocks.assetsStore,
    );
    navigator = AccountDetailsNavigator(Mocks.appNavigator);
    presenter = AccountDetailsPresenter(
      model,
      navigator,
    );
    page = AccountDetailsPage(presenter: presenter);
  }

  screenshotTest(
    'account_details_page',
    setUp: () {
      _initMvp();
      when(() => Mocks.assetsStore.getAssets(any())).thenAnswer(
        (invocation) => [
          Asset(
            verifiedDenom: verifiedDenom,
            chainAssets: [ChainAsset.empty()],
          ),
        ],
      );

      when(() => Mocks.accountsStore.currentAccount).thenAnswer((invocation) => myAccount);

      when(() => Mocks.blockchainMetadataStore.prices).thenAnswer(
        (invocation) => Prices(
          tokens: [TokenPair.zero()],
          fiats: const [FiatPair(ticker: '', price: 0)],
        ),
      );
    },
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  screenshotTest(
    'account_details_page_empty',
    setUp: () {
      _initMvp();
      when(() => Mocks.assetsStore.getAssets(any())).thenAnswer((invocation) => const []);

      when(() => Mocks.accountsStore.currentAccount).thenAnswer((invocation) => const EmerisAccount.empty());

      when(() => Mocks.blockchainMetadataStore.prices).thenAnswer(
        (invocation) => Prices(
          tokens: [TokenPair.zero()],
          fiats: const [FiatPair(ticker: '', price: 0)],
        ),
      );
    },
    pageBuilder: (theme) => TestAppWidget(
      themeData: theme,
      child: page,
    ),
  );

  test('getIt page resolves successfully', () async {
    expect(getIt<AccountDetailsPage>(param1: _MockAccountDetailsInitialParams()), isNotNull);
  });
}

class _MockAccountDetailsInitialParams extends Mock implements AccountDetailsInitialParams {}
