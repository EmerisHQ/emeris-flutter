import 'package:emeris_app/presentation/routing/routing_presentation_model.dart';
import 'package:emeris_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:emeris_app/ui/pages/routing/routing_navigator.dart';
import 'package:emeris_app/utils/app_initializer.dart';

class RoutingPresenter {
  RoutingPresenter(
    this._model,
    this.navigator,
    this._appInitializer,
  );

  final RoutingPresentationModel _model;
  final RoutingNavigator navigator;
  final AppInitializer _appInitializer;

  RoutingViewModel get viewModel => _model;

  Future<void> init() async {
    await _appInitializer.init();
    navigator.close();
    if (_model.wallets.isEmpty) {
      navigator.openMnemonicOnboarding();
    } else {
      navigator.openWalletsList(const WalletsListInitialParams());
    }
  }
}
