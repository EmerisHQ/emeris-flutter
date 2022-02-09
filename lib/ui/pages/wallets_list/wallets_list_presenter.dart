import 'package:cosmos_ui_components/components/template/cosmos_wallets_list_view.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/use_cases/change_current_wallet_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class WalletsListPresenter {
  WalletsListPresenter(
    this._model,
    this.navigator,
    this._changeCurrentWalletUseCase,
  );

  final WalletsListPresentationModel _model;
  final WalletsListNavigator navigator;
  final ChangeCurrentWalletUseCase _changeCurrentWalletUseCase;

  WalletsListViewModel get viewModel => _model;

  Future<void> addWalletClicked() async => showNotImplemented();

  void walletClicked(EmerisWallet wallet) {
    _changeCurrentWalletUseCase.execute(wallet: wallet).observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => doNothing(),
        );
    navigator.appNavigator.close(navigator.context);
  }

  void editClicked() => _model.isEditingAccountList = !_model.isEditingAccountList;

  void onTapImportWallet() => navigator.openImportWallet(const ImportWalletInitialParams());

  void onTapCreateWallet() => navigator.openAddWallet(const AddWalletInitialParams());

  void onTapClose() => navigator.close();

  void onTapEditWallet(WalletInfo wallet) => showNotImplemented();
}
