// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class PasswordGenerationViewModel {
  bool get isPasswordVisible;

  String get password;
}

class PasswordGenerationPresentationModel
    with PasswordGenerationPresentationModelBase
    implements PasswordGenerationViewModel {
  final PasswordGenerationInitialParams initialParams;

  PasswordGenerationPresentationModel(this.initialParams);

  String get mnemonic => initialParams.mnemonic;

  @override
  bool get isPasswordVisible => _isPasswordVisible.value;

  @override
  String get password => _password.value;
}

//////////////////BOILERPLATE
abstract class PasswordGenerationPresentationModelBase {
  //////////////////////////////////////
  final Observable<bool> _isPasswordVisible = Observable(false);

  set isPasswordVisible(bool value) => Action(() => _isPasswordVisible.value = value)();

  //////////////////////////////////////
  final Observable<String> _password = Observable("");

  set password(String value) => Action(() => _password.value = value)();
}
