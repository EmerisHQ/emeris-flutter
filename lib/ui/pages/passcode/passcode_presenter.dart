import 'package:cosmos_utils/extensions.dart';
import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/domain/entities/failures/passcode_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/use_cases/save_passcode_use_case.dart';
import 'package:flutter_app/domain/use_cases/verify_passcode_use_case.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_navigator.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_presentation_model.dart';
import 'package:flutter_app/utils/utils.dart';

class PasscodePresenter {
  PasscodePresenter(
    this._model,
    this.navigator,
    this._verifyPasscodeUseCase,
    this._savePasscodeUseCase,
  );

  final PasscodePresentationModel _model;
  final PasscodeNavigator navigator;
  final VerifyPasscodeUseCase _verifyPasscodeUseCase;
  final SavePasscodeUseCase _savePasscodeUseCase;

  PasscodeViewModel get viewModel => _model;

  void onPasscodeSubmit(String value) {
    _model.passcodeValueKey++;
    switch (_model.mode) {
      case PasscodeMode.firstPasscode:
        _model.firstPasscodeText = value;
        if (_model.hasPasscode) {
          _verifyPasscode();
        } else {
          _model.mode = PasscodeMode.confirmPasscode;
        }
        break;
      case PasscodeMode.confirmPasscode:
        _model.confirmPasscodeText = value;
        _verifyPasscode();
        break;
    }
  }

  Future<void> _verifyPasscode() async {
    final firstPass = Passcode(_model.firstPasscodeText);
    final confirmPass = Passcode(_model.confirmPasscodeText);
    final validationError = firstPass.validateError();
    switch (_model.mode) {
      case PasscodeMode.firstPasscode:
        await _verifyPasscodeUseCase.execute(_model.passcode).doOn(
              fail: (fail) => navigator.showError(fail.displayableFailure()),
              success: (isValid) {
                if (isValid) {
                  navigator.closeWithResult(_model.passcode);
                } else {
                  _showError(
                    const PasscodeFailure.passcodesDontMatch().displayableFailure(),
                  );
                }
              },
            );
        return;
      case PasscodeMode.confirmPasscode:
        if (firstPass == confirmPass && validationError == null) {
          _model.savePasscodeFuture = _savePasscodeUseCase
              .execute(firstPass) //
              .observableDoOn(
                (fail) => _showError(fail.displayableFailure()),
                (success) => navigator.closeWithResult(firstPass),
              );
          await _model.savePasscodeFuture;
        } else {
          await _showError(
            validationError == null
                ? const PasscodeFailure.passcodesDontMatch().displayableFailure()
                : validationError.displayableFailure(),
          );
        }
    }
  }

  Future<void> _showError(DisplayableFailure fail) {
    _model
      ..firstPasscodeText = ''
      ..confirmPasscodeText = ''
      ..mode = PasscodeMode.firstPasscode;

    return navigator.showError(fail);
  }
}
