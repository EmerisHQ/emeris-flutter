import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';

abstract class RoutingViewModel {}

class RoutingPresentationModel with RoutingPresentationModelBase implements RoutingViewModel {
  RoutingPresentationModel(this._initialParams, this._accountsStore);

  final AccountsStore _accountsStore;
  final RoutingInitialParams _initialParams;

  List<EmerisAccount> get accounts => _accountsStore.accounts;

  bool get initializeApp => _initialParams.initializeApp;
}

//////////////////BOILERPLATE
mixin RoutingPresentationModelBase {}
