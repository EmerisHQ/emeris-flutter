// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/send_money/send_money_initial_params.dart';

abstract class SendMoneyViewModel {}

class SendMoneyPresentationModel with SendMoneyPresentationModelBase implements SendMoneyViewModel {
  SendMoneyPresentationModel(this._initialParams);

  // ignore: unused_field
  final SendMoneyInitialParams _initialParams;
}

//////////////////BOILERPLATE
abstract class SendMoneyPresentationModelBase {}
