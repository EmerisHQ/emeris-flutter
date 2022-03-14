// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';

abstract class ReceiveViewModel {
  String get accountAddress;

  String get accountAlias;
}

class ReceivePresentationModel with ReceivePresentationModelBase implements ReceiveViewModel {
  ReceivePresentationModel(this.initialParams);

  final ReceiveInitialParams initialParams;

  EmerisAccount get account => initialParams.account;

  @override
  String get accountAddress => account.accountDetails.accountAddress;

  @override
  String get accountAlias => account.accountDetails.accountAlias;
}

//////////////////BOILERPLATE
abstract class ReceivePresentationModelBase {}
