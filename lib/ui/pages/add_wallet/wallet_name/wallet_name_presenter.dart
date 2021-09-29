import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_presentation_model.dart';

class WalletNamePresenter {
  WalletNamePresenter(
    this._model,
    this.navigator,
  );

  final WalletNamePresentationModel _model;
  final WalletNameNavigator navigator;

  WalletNameViewModel get viewModel => _model;

  void onTapSubmit() => navigator.closeWithResult("wallet name"); // TODO
}
