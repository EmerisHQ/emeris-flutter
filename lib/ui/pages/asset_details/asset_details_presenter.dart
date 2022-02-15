import 'package:flutter_app/domain/use_cases/get_chain_assets_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_staked_amount_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_navigator.dart';
import 'package:flutter_app/ui/pages/asset_details/asset_details_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class AssetDetailsPresenter {
  AssetDetailsPresenter(
    this._model,
    this.navigator,
    this._getStakedAmountUseCase,
    this._getChainAssetsUseCase,
  );

  final AssetDetailsPresentationModel _model;
  final AssetDetailsNavigator navigator;
  final GetStakedAmountUseCase _getStakedAmountUseCase;
  final GetChainAssetsUseCase _getChainAssetsUseCase;

  AssetDetailsViewModel get viewModel => _model;

  void init() {
    _getStakedAmount();
    _getAssetSpecificChains();
  }

  Future<void> _getStakedAmount() async {
    _model.getStakedAmountFuture = _getStakedAmountUseCase
        .execute(
          wallet: _model.wallet,
          onChain: _model.onChain,
        )
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (stakedAmount) => _model.stakedAmount = stakedAmount,
        );
  }

  Future<void> _getAssetSpecificChains() async {
    _model.getChainAssetsDetailsFuture = _getChainAssetsUseCase
        .execute(
          balances: _model.balances,
          baseDenom: _model.baseDenom,
        )
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (chains) => _model.chainAssets = chains,
        );
  }

  void onTapReceive() => showNotImplemented();

  void onTapSend() => showNotImplemented();
}
