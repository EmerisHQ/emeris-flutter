import 'package:flutter_app/domain/entities/failures/passcode_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presentation_model.dart';

class PasscodePresenter {
  PasscodePresenter(
    this._model,
    this.navigator,
  );

  final PasscodePresentationModel _model;
  final PasscodeNavigator navigator;

  PasscodeViewModel get viewModel => _model;

  void onTapSubmit() => navigator.closeWithResult(const Passcode(value: '123456')); // TODO

  void onPasscodeSubmit(String value) {
    switch (_model.mode) {
      case PasscodeMode.firstPasscode:
        _model.firstPasscodeText = value;
        if (_model.requirePasscodeConfirmation) {
          _model.mode = PasscodeMode.confirmPasscode;
        } else {
          navigator.closeWithResult(_model.passcode);
        }
        break;
      case PasscodeMode.confirmPasscode:
        _model.confirmPasscodeText = value;
        if (_model.firstPasscodeText != _model.confirmPasscodeText) {
          navigator.showError(
            const PasscodeFailure.passcodesDontMatch().displayableFailure(),
          );
          _model
            ..firstPasscodeText = ''
            ..confirmPasscodeText = ''
            ..mode = PasscodeMode.firstPasscode;
        } else {
          navigator.closeWithResult(_model.passcode);
        }
        break;
    }
  }
}
