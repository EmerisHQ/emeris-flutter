import 'package:cosmos_utils/extensions.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/failures/invalid_passcode_failure.dart';
import 'package:flutter_app/domain/entities/gas_price_level.dart';
import 'package:flutter_app/domain/use_cases/paste_from_clipboard_use_case.dart';
import 'package:flutter_app/domain/use_cases/send_tokens_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_form_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class SendTokensPresenter {
  SendTokensPresenter(
    this._model,
    this.navigator,
    this._pasteFromClipboardUseCase,
    this._sendTokensUseCase,
  );

  final SendTokensPresentationModel _model;
  final SendTokensNavigator navigator;
  final PasteFromClipboardUseCase _pasteFromClipboardUseCase;
  final SendTokensUseCase _sendTokensUseCase;

  SendTokensViewModel get viewModel => _model;

  // ignore: use_setters_to_change_properties
  void onChangedRecipientAddress(String value) => _model.recipientAddress = AccountAddress(value: value);

  void onTapConfirmRecipientCheckbox() => _model.recipientConfirmed = !_model.recipientConfirmed;

  void onTapPaste() => _pasteFromClipboardUseCase.execute().doOn(
        success: (text) => _model.recipientAddress = AccountAddress(value: text),
      );

  void onTapScanRecipientAddress() => showNotImplemented();

  void onTapContinue() {
    switch (_model.step) {
      case SendTokensFormStep.recipient:
        _model.step = SendTokensFormStep.amount;
        break;
      case SendTokensFormStep.amount:
        _model.step = SendTokensFormStep.review;
        break;
      case SendTokensFormStep.review:
        _sendTokens();
        break;
    }
  }

  // ignore: use_setters_to_change_properties
  void onChangeMemo(String value) => _model.memo = value;

  Future<void> _sendTokens() async {
    if (_model.isInterChainTransfer) {
      //TODO implement IBC token transfers
      showNotImplemented();
    } else {
      final passcode = await navigator.openPasscode(const PasscodeInitialParams());
      if (passcode == null) {
        return navigator.showError(const InvalidPasscodeFailure().displayableFailure());
      }
      _model.sendTokensFuture = _sendTokensUseCase
          .execute(
            accountIdentifier: _model.account.id,
            passcode: passcode,
            sendMoneyData: _model.formData,
          )
          .observableDoOn(
            (fail) => navigator.showError(fail.displayableFailure()),
            navigator.closeWithResult,
          );
    }
  }

  Future<bool> onWillPop() async => onTapBack();

  bool onTapBack() {
    if (_model.step.index > 0) {
      _model.step = SendTokensFormStep.values[_model.step.index - 1];
      return false;
    } else {
      navigator.close();
      return true;
    }
  }

  // ignore: use_setters_to_change_properties
  void onChangedAmount(String amount) => _model.amountText = amount;

  void onTapMaxAmount() => _model.setMaxAmount();

  void onTapCurrencySwitch() => _model.switchCurrency();

  Future<void> onTapBalanceSelector() async {
    final asset = await navigator.openBalanceSelector(
      const BalanceSelectorInitialParams(),
    );
    if (asset != null && asset != _model.selectedAsset) {
      _model
        ..amountText = ''
        ..selectedAsset = asset;
    }
  }

  // ignore: use_setters_to_change_properties
  void onTapGasPriceLevel(GasPriceLevel level) {
    _model.appliedFee = level;
  }
}
