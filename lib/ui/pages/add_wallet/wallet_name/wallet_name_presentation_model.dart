// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class WalletNameViewModel {}

class WalletNamePresentationModel with WalletNamePresentationModelBase implements WalletNameViewModel {
  WalletNamePresentationModel(this.initialParams);

  final WalletNameInitialParams initialParams;

  String get name => _name.value;
}

//////////////////BOILERPLATE
mixin WalletNamePresentationModelBase {
  //////////////////////////////////////
  final Observable<String> _name = Observable('');

  set name(String value) => Action(() => _name.value = value)();
}
