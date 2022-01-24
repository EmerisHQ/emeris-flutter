import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

part 'wallet_details_presentation_model.dart';

class WalletDetailsPresenter {
  final WalletDetailsPresentationModel _model;
  final WalletDetailsNavigator navigator;
  final GetBalancesUseCase _getBalancesUseCase;

  WalletDetailsViewModel get viewModel => _model;

  WalletDetailsPresenter(
    this._model,
    this.navigator,
    this._getBalancesUseCase,
  );

  Future<void> getWalletBalances(EmerisWallet walletData) async {
    _model.getAssetDetailsFuture = _getBalancesUseCase.execute(walletData: walletData).observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (balances) => _model.balanceList = balances,
        );
  }

  void transferTapped({required Balance balance, required AssetDetails assetDetails}) =>
      navigator.openAssetDetails(balance: balance, assetDetails: assetDetails);

  void onTapPortfolioHeading() => navigator.openWalletsList(const WalletsListInitialParams());

  void onReceivePressed() => showNotImplemented();

  void onSendPressed() => showNotImplemented();
}
