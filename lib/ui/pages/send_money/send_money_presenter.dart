import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presentation_model.dart';

class SendMoneyPresenter {
  SendMoneyPresenter(
    this._model,
    this.navigator,
  );

  final SendMoneyPresentationModel _model;
  final SendMoneyNavigator navigator;

  SendMoneyViewModel get viewModel => _model;
}
