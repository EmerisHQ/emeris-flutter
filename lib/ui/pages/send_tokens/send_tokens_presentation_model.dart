// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_form_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:mobx/mobx.dart';

abstract class SendTokensViewModel {
  SendTokensFormStep get step;

  String get title;

  bool get recipientConfirmed;

  String get recipientAddress;

  String get memo;

  bool get continueButtonEnabled;
}

class SendTokensPresentationModel with SendTokensPresentationModelBase implements SendTokensViewModel {
  SendTokensPresentationModel(this._initialParams);

  // ignore: unused_field
  final SendTokensInitialParams _initialParams;

  @override
  SendTokensFormStep get step => _step.value;

  @override
  String get title {
    switch (step) {
      case SendTokensFormStep.recipient:
        return strings.recipientStepTitle;
      case SendTokensFormStep.amount:
        return strings.amountStepTitle;
      case SendTokensFormStep.review:
        return strings.reviewStepTitle;
    }
  }

  @override
  bool get recipientConfirmed => _recipientConfirmed.value;

  @override
  String get recipientAddress => _recipientAddress.value;

  @override
  String get memo => _memo.value;

  @override
  bool get continueButtonEnabled {
    switch (step) {
      case SendTokensFormStep.recipient:
        return recipientConfirmed && recipientAddress.isNotEmpty;
      case SendTokensFormStep.amount:
        // TODO: Handle this case.
        return false;
      case SendTokensFormStep.review:
        // TODO: Handle this case.
        return false;
    }
  }
}

//////////////////BOILERPLATE
abstract class SendTokensPresentationModelBase {
  //////////////////////////////////////
  final Observable<SendTokensFormStep> _step = Observable(SendTokensFormStep.recipient);

  set step(SendTokensFormStep value) => Action(() => _step.value = value)();

  //////////////////////////////////////
  final Observable<bool> _recipientConfirmed = Observable(false);

  set recipientConfirmed(bool value) => Action(() => _recipientConfirmed.value = value)();

  //////////////////////////////////////
  final Observable<String> _recipientAddress = Observable('');

  set recipientAddress(String value) => Action(() => _recipientAddress.value = value)();

  //////////////////////////////////////
  final Observable<String> _memo = Observable('');

  set memo(String value) => Action(() => _memo.value = value)();
}
