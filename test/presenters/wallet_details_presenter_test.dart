import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late WalletDetailsInitialParams initParams;
  late WalletDetailsPresentationModel model;
  late WalletDetailsPresenter presenter;
  late WalletDetailsNavigator navigator;
  late MockWalletsStore walletsStore;
  late MockBlockchainMetadataStore blockchainMetadataStore;
  late MockGetBalancesUseCase getBalancesUseCase;
  late EmerisWallet myWallet;
  late Balance balance;
  const fromAddress = 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav';

  void _initMvp() {
    initParams = const WalletDetailsInitialParams();
    model = WalletDetailsPresentationModel(
      initParams,
      walletsStore,
      blockchainMetadataStore,
    );
    navigator = MockWalletDetailsNavigator();
    presenter = WalletDetailsPresenter(
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
      await presenter.getWalletBalances(myWallet);
      //
      //THEN
      verify(
        () => getBalancesUseCase.execute(
          walletData: myWallet,
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
    registerFallbackValue(const WalletDetailsInitialParams());
    walletsStore = MockWalletsStore();
    blockchainMetadataStore = MockBlockchainMetadataStore();
    getBalancesUseCase = MockGetBalancesUseCase();
    balance = Balance(
      denom: const Denom('ATOM'),
      amount: Amount.fromInt(100),
    );
    myWallet = const EmerisWallet(
      walletDetails: WalletDetails(
        walletIdentifier: WalletIdentifier(
          walletId: 'walletId',
          chainId: 'cosmos',
        ),
        walletAlias: 'Name of the wallet',
        walletAddress: fromAddress,
      ),
      walletType: WalletType.Cosmos,
    );
    when(
      () => getBalancesUseCase.execute(
        walletData: myWallet,
      ),
    ).thenAnswer(
      (_) => successFuture(
        [balance],
      ),
    );
  });
}
