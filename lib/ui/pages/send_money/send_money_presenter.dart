// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/invalid_amount_failure.dart';
import 'package:flutter_app/domain/entities/failures/invalid_passcode_failure.dart';
import 'package:flutter_app/domain/entities/failures/no_wallet_selected_failure.dart';
import 'package:flutter_app/domain/entities/send_money_form_data.dart';
import 'package:flutter_app/domain/use_cases/send_money_use_case.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
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

  Future<void> onTapSendMoney() async {
    final walletId = _model.walletIdentifier;
    if (walletId == null) {
      return navigator.showError(const NoWalletSelectedFailure().displayableFailure());
    }
    final passcode = await navigator.openPasscode(const PasscodeInitialParams());
    if (passcode == null) {
      return navigator.showError(const InvalidPasscodeFailure().displayableFailure());
    }
    if (!_model.isAmountValid) {
      return navigator.showError(const InvalidAmountFailure().displayableFailure());
    }
    _model.sendMoneyFuture = _sendMoneyUseCase
        .execute(
          sendMoneyData: SendMoneyFormData(
            balance: Balance(
              denom: viewModel.denom,
              amount: _model.amount,
              onChain: '',
            ),
            walletType: _model.walletType,
            fromAddress: _model.senderAddress,
            toAddress: _model.recipientAddress,
          ),
          walletIdentifier: walletId,
          passcode: passcode,
        )
        .observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => navigator.close(),
        );
  }

  void onChangedRecipient(String value) {
    _model.recipientAddress = value;
  }

  void onChangedAmount(String value) {
    _model.amountString = value;
  }
}
