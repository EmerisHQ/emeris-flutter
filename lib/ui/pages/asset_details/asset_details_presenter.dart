import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/use_cases/get_staked_amount_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class AssetDetailsPresenter {
  AssetDetailsPresenter(this._model, this.navigator, this._getStakedAmountUseCase);

  final AssetDetailsPresentationModel _model;
  final AssetDetailsNavigator navigator;
  final GetStakedAmountUseCase _getStakedAmountUseCase;

  AssetDetailsViewModel get viewModel => _model;

  void onReceivePressed() => showNotImplemented();

  void onSendPressed() => showNotImplemented();

  Future<void> getStakedAmount(EmerisWallet wallet, String onChain) async {
    _model.getStakedAmountFuture = _getStakedAmountUseCase.execute(wallet: wallet, onChain: onChain).observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (stakedAmount) => _model.stakedAmount = stakedAmount,
        );
  }
}
