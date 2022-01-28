import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter_app/domain/entities/failures/no_wallet_selected_failure.dart';
import 'package:flutter_app/domain/entities/send_money_message.dart';
import 'package:flutter_app/domain/use_cases/send_money_use_case.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class SendMoneyPresenter {
  SendMoneyPresenter(
    this._model,
    this.navigator,
    this._sendMoneyUseCase,
  );

  final SendMoneyPresentationModel _model;
  final SendMoneyNavigator navigator;
  late final SendMoneyUseCase _sendMoneyUseCase;

  SendMoneyViewModel get viewModel => _model;

  Future<void> sendMoney(SendMoneyMessage data) async {
    final walletId = _model.walletIdentifier;
    if (walletId == null) {
      await navigator.showError(const NoWalletSelectedFailure().displayableFailure());
      return;
    }
    _model.sendMoneyFuture = _sendMoneyUseCase
        .execute(
          sendMoneyData: data,
          walletIdentifier: walletId,
        )
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => doNothing(),
        );
  }
}
