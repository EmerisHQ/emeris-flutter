import 'package:flutter_app/domain/use_cases/get_staked_amount_use_case.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';

class AssetDetailsPresenter {
  AssetDetailsPresenter(
    this._model,
    this.navigator,
    this._getStakedAmountUseCase,
  );

  final AssetDetailsPresentationModel _model;
  final AssetDetailsNavigator navigator;
  final GetStakedAmountUseCase _getStakedAmountUseCase;

  AssetDetailsViewModel get viewModel => _model;

  void init() {
    _getStakedAmount();
  }

  Future<void> _getStakedAmount() async {
    _model.getStakedAmountFuture = _getStakedAmountUseCase
        .execute(
          account: _model.account,
        )
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (stakedAmount) => _model.stakedAmount = stakedAmount,
        );
  }

  void onTapReceive() => navigator.openReceive(
        ReceiveInitialParams(
          account: _model.account,
        ),
      );

  void onTapSend() {
    navigator.openSendTokens(SendTokensInitialParams(_model.asset));
  }
}
