// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';

abstract class ReceiveViewModel {
  String get walletAddress;

  String get walletAlias;
}

class ReceivePresentationModel with ReceivePresentationModelBase implements ReceiveViewModel {
  ReceivePresentationModel(this.initialParams);

  final ReceiveInitialParams initialParams;

  EmerisWallet get wallet => initialParams.wallet;

  @override
  String get walletAddress => wallet.walletDetails.walletAddress;

  @override
  String get walletAlias => wallet.walletDetails.walletAlias;
}

//////////////////BOILERPLATE
abstract class ReceivePresentationModelBase {}
