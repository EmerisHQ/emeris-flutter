// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/add_wallet/wallet_name/wallet_name_initial_params.dart';

abstract class WalletNameViewModel {}

class WalletNamePresentationModel with WalletNamePresentationModelBase implements WalletNameViewModel {
  final WalletNameInitialParams initialParams;

  WalletNamePresentationModel(this.initialParams);
}

//////////////////BOILERPLATE
abstract class WalletNamePresentationModelBase {}
