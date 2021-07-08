import 'package:flutter_app/domain/entities/send_money_data.dart';
import 'package:flutter_app/domain/use_cases/send_money_use_case.dart';
import 'package:flutter_app/presentation/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/utils/utils.dart';

class SendMoneyPresenter {
  final SendMoneyPresentationModel _model;
  final SendMoneyNavigator navigator;
  late final SendMoneyUseCase _sendMoneyUseCase;

  SendMoneyViewModel get viewModel => _model;

  SendMoneyPresenter(
    this._model,
    this.navigator,
    this._sendMoneyUseCase,
  );

  Future<void> sendMoney(SendMoneyData data) async {
    _model.sendMoneyFuture = _sendMoneyUseCase.execute(sendMoneyData: data).observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => doNothing(),
        );
  }
}
