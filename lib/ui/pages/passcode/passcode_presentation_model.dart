// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:mobx/mobx.dart';

enum PasscodeMode {
  firstPasscode,
  confirmPasscode,
}

abstract class PasscodeViewModel {
  PasscodeMode get mode;

  String get firstPasscodeText;

  String get confirmPasscodeText;
}

class PasscodePresentationModel with PasscodePresentationModelBase implements PasscodeViewModel {
  final PasscodeInitialParams _initialParams;

  PasscodePresentationModel(this._initialParams);

  @override
  String get firstPasscodeText => _firstPasscodeText.value;

  @override
  String get confirmPasscodeText => _confirmPasscodeText.value;

  bool get requirePasscodeConfirmation => _initialParams.requirePasscodeConfirmation;

  @override
  PasscodeMode get mode => _mode.value;

  Passcode get passcode => Passcode(value: firstPasscodeText);
}

//////////////////BOILERPLATE
abstract class PasscodePresentationModelBase {
  //////////////////////////////////////
  final Observable<String> _firstPasscodeText = Observable("");

  set firstPasscodeText(String value) => Action(() => _firstPasscodeText.value = value)();

  //////////////////////////////////////
  final Observable<String> _confirmPasscodeText = Observable("");

  set confirmPasscodeText(String value) => Action(() => _confirmPasscodeText.value = value)();

  //////////////////////////////////////
  final Observable<PasscodeMode> _mode = Observable(PasscodeMode.firstPasscode);

  set mode(PasscodeMode value) => Action(() => _mode.value = value)();
}
