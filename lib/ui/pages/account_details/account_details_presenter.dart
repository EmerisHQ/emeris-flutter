import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_initial_params.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';

class AccountDetailsPresenter {
  AccountDetailsPresenter(
    this._model,
    this.navigator,
    this._getBalancesUseCase,
  );

  final AccountDetailsPresentationModel _model;
  final AccountDetailsNavigator navigator;
  final GetBalancesUseCase _getBalancesUseCase;

  AccountDetailsViewModel get viewModel => _model;

  Future<void> init() async {
    await getAccountBalances(_model.account);
    _model.listenToAccountChanges(doOnChange: getAccountBalances);
  }

  void dispose() {
    _model.dispose();
  }

  Future<void> getAccountBalances(EmerisAccount account) async {
    _model.getAssetDetailsFuture = _getBalancesUseCase //
        .execute(accountData: account)
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (balances) => _model.balanceList = balances,
        );
  }

  void onTapTransfer({required Balance balance}) => navigator.openAssetDetails(
        AssetDetailsInitialParams(
          balance: balance,
          assetDetails: _model.assetDetails,
          account: _model.account,
        ),
      );

  void onTapPortfolioHeading() => navigator.openAccountsList(
        const AccountsListInitialParams(),
      );

  void onTapReceive() => navigator.openReceive(ReceiveInitialParams(account: _model.account));

  void onTapSend() => navigator.openSendTokens(
        const SendTokensInitialParams(),
      );
}
