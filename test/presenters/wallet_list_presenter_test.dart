import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late WalletsListInitialParams initParams;
  late WalletsListPresentationModel model;
  late WalletsListPresenter presenter;
  late WalletsListNavigator navigator;
  late MockWalletsStore walletsStore;
  late MockChangeCurrentWalletUseCase changeCurrentWalletUseCase;
  late MockDeleteWalletUseCase deleteWalletUseCase;
  late EmerisWallet myWallet;
  const fromAddress = 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav';

  void _initMvp() {
    initParams = const WalletsListInitialParams();
    model = WalletsListPresentationModel(walletsStore, initParams);
    navigator = MockWalletsListNavigator();
    presenter = WalletsListPresenter(
      model,
      navigator,
      changeCurrentWalletUseCase,
      deleteWalletUseCase,
    );
  }

  test(
    'Changing the current wallet should fill the `selectedWallet` inside the presentationModel',
    () async {
      // GIVEN
      _initMvp();
      // WHEN
      presenter.walletClicked(myWallet);
      //
      //THEN
      verify(
        () => changeCurrentWalletUseCase.execute(
          wallet: myWallet,
        ),
      );
      expect(
        model.selectedWallet,
        myWallet,
      );
    },
  );

  setUp(() {
    walletsStore = MockWalletsStore();
    changeCurrentWalletUseCase = MockChangeCurrentWalletUseCase();
    deleteWalletUseCase = MockDeleteWalletUseCase();
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
    when(() => walletsStore.currentWallet).thenReturn(myWallet);
    when(
      () => changeCurrentWalletUseCase.execute(wallet: myWallet),
    ).thenAnswer(
      (_) => successFuture(unit),
    );
  });
}
