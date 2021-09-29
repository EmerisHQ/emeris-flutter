import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';

class WalletsListPresenter {
  WalletsListPresenter(
    this._model,
    this.navigator,
  );

  final WalletsListPresentationModel _model;
  final WalletsListNavigator navigator;

  WalletsListViewModel get viewModel => _model;

  Future<void> addWalletClicked() async => notImplemented(AppNavigator.navigatorKey.currentContext!);

  void walletClicked(EmerisWallet wallet) => navigator.openWalletDetails(wallet);
}
