import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_presentation_model.dart';

class BalanceSelectorPresenter {
  const BalanceSelectorPresenter(
    this._model,
    this.navigator,
  );

  final BalanceSelectorPresentationModel _model;
  final BalanceSelectorNavigator navigator;

  BalanceSelectorViewModel get viewModel => _model;

  void onSelectedChainAsset(ChainAsset chainAsset) => navigator.closeWithResult(chainAsset);
}
