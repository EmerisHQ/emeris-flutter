// ignore_for_file: avoid_setters_without_getters
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/save_passcode_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

enum PasscodeMode {
  firstPasscode,
  confirmPasscode,
}

abstract class PasscodeViewModel {
  PasscodeMode get mode;

  String get firstPasscodeText;

  String get confirmPasscodeText;

  bool get isLoading;

  int get passcodeValueKey;
}

class PasscodePresentationModel with PasscodePresentationModelBase implements PasscodeViewModel {
  PasscodePresentationModel(
    this._initialParams,
    this._settingsStore,
  );

  final SettingsStore _settingsStore;

  // ignore: unused_field
  final PasscodeInitialParams _initialParams;

  @override
  String get firstPasscodeText => _firstPasscodeText.value;

  @override
  String get confirmPasscodeText => _confirmPasscodeText.value;

  @override
  PasscodeMode get mode => _mode.value;

  Passcode get passcode => Passcode(firstPasscodeText);

  bool get hasPasscode => _settingsStore.hasPasscode;

  ObservableFuture<Either<SavePasscodeFailure, Unit>>? get savePasscodeFuture => _savePasscodeFuture.value;

  @override
  bool get isLoading => isFutureInProgress(savePasscodeFuture);

  @override

  /// this is used by the UI to determine the ValueKey used for the passcode widget. for each attempt of passcode this value needs to be unique
  int get passcodeValueKey => _passcodeValueKey.value;
}

//////////////////BOILERPLATE
mixin PasscodePresentationModelBase {
  //////////////////////////////////////
  final Observable<String> _firstPasscodeText = Observable('');

  set firstPasscodeText(String value) => Action(() => _firstPasscodeText.value = value)();

  //////////////////////////////////////
  final Observable<String> _confirmPasscodeText = Observable('');

  set confirmPasscodeText(String value) => Action(() => _confirmPasscodeText.value = value)();

  //////////////////////////////////////
  final Observable<PasscodeMode> _mode = Observable(PasscodeMode.firstPasscode);

  set mode(PasscodeMode value) => Action(() => _mode.value = value)();

  //////////////////////////////////////
  final Observable<ObservableFuture<Either<SavePasscodeFailure, Unit>>?> _savePasscodeFuture = Observable(null);

  set savePasscodeFuture(ObservableFuture<Either<SavePasscodeFailure, Unit>>? value) =>
      Action(() => _savePasscodeFuture.value = value)();

  //////////////////////////////////////
  final Observable<int> _passcodeValueKey = Observable(0);

  set passcodeValueKey(int value) => Action(() => _passcodeValueKey.value = value)();
}
