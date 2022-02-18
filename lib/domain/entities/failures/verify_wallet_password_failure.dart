import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

enum _VerifyWalletPasswordFailureType {
  InvalidPassword,
}

class VerifyWalletPasswordFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const VerifyWalletPasswordFailure.invalidPassword() : _type = _VerifyWalletPasswordFailureType.InvalidPassword;

  final _VerifyWalletPasswordFailureType _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _VerifyWalletPasswordFailureType.InvalidPassword:
        return DisplayableFailure(
          title: strings.verifyPasswordErrorTitle,
          message: strings.verifyPasswordErrorMessage,
        );
    }
  }
}