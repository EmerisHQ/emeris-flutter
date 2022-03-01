import 'package:cosmos_utils/extensions.dart';
import 'package:flutter_app/domain/use_cases/paste_from_clipboard_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_form_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presentation_model.dart';

class SendTokensPresenter {
  SendTokensPresenter(
    this._model,
    this.navigator,
    this._pasteFromClipboardUseCase,
  );

  final SendTokensPresentationModel _model;
  final SendTokensNavigator navigator;
  final PasteFromClipboardUseCase _pasteFromClipboardUseCase;

  SendTokensViewModel get viewModel => _model;

  // ignore: use_setters_to_change_properties
  void onChangedRecipientAddress(String value) => _model.recipientAddress = value;

  void onTapConfirmRecipientCheckbox() => _model.recipientConfirmed = !_model.recipientConfirmed;

  void onTapPaste() => _pasteFromClipboardUseCase.execute().doOn(
        success: (text) => _model.recipientAddress = text,
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

  void _sendTokens() => showNotImplemented();

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
}
