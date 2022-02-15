import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';

class WalletDetailsPresenter {
  WalletDetailsPresenter(
    this._model,
    this.navigator,
    this._getBalancesUseCase,
  );

  final WalletDetailsPresentationModel _model;
  final WalletDetailsNavigator navigator;
  final GetBalancesUseCase _getBalancesUseCase;

  WalletDetailsViewModel get viewModel => _model;

  Future<void> init() async {
    await getWalletBalances(_model.wallet);
    _model.listenToWalletChanges(getWalletBalances);
  }

  void dispose() {
    _model.dispose();
  }

  Future<void> getWalletBalances(EmerisWallet wallet) async {
    _model.getAssetDetailsFuture = _getBalancesUseCase.execute(walletData: wallet).observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (balances) => _model.balanceList = balances,
        );
  }

  void onTapTransfer({required Balance balance}) => navigator.openAssetDetails(
        AssetDetailsInitialParams(
          balance: balance,
          assetDetails: _model.assetDetails,
          wallet: _model.wallet,
        ),
      );

  void onTapPortfolioHeading() => navigator.openWalletsList(
        const WalletsListInitialParams(),
      );

  void onTapReceive() => navigator.openReceive(ReceiveInitialParams(wallet: _model.wallet));

  void onTapSend() => showNotImplemented();
}
