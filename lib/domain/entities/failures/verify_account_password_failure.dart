import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

enum _VerifyAccountPasswordFailureType {
  InvalidPassword,
}

class VerifyAccountPasswordFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const VerifyAccountPasswordFailure.invalidPassword() : _type = _VerifyAccountPasswordFailureType.InvalidPassword;

  final _VerifyAccountPasswordFailureType _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _VerifyAccountPasswordFailureType.InvalidPassword:
        return DisplayableFailure(
          title: strings.verifyPasswordErrorTitle,
          message: strings.verifyPasswordErrorMessage,
        );
    }
  }
}
