import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_navigator.dart';
import 'package:flutter_app/ui/pages/account_details/account_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/accounts_list/accounts_list_initial_params.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_initial_params.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';

class AccountDetailsPresenter {
  AccountDetailsPresenter(
    this._model,
    this.navigator,
  );

  final AccountDetailsPresentationModel _model;
  final AccountDetailsNavigator navigator;

  AccountDetailsViewModel get viewModel => _model;

  void onTapTransfer(Asset asset) => navigator.openAssetDetails(
        AssetDetailsInitialParams(
          asset: asset,
          account: _model.account,
        ),
      );

  void onTapPortfolioHeading() => navigator.openAccountsList(
        const AccountsListInitialParams(),
      );

  void onTapReceive() => navigator.openReceive(ReceiveInitialParams(account: _model.account));

  void onTapSend() {
    if (_model.assets.isEmpty) {
      return;
    }
    navigator.openSendTokens(SendTokensInitialParams(_model.assets.first));
  }
}
