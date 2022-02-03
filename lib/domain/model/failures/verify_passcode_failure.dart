import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/domain/model/failures/passcode_validation_failure.dart';

enum VerifyPasscodeFailureType {
  Unknown,
  ValidationError,
}

class VerifyPasscodeFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const VerifyPasscodeFailure.unknown([this.cause]) : type = VerifyPasscodeFailureType.Unknown;

  const VerifyPasscodeFailure.validationError(PasscodeValidationFailure fail)
      : cause = fail,
        type = VerifyPasscodeFailureType.ValidationError;

  final VerifyPasscodeFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case VerifyPasscodeFailureType.Unknown:
        return DisplayableFailure.commonError();
      case VerifyPasscodeFailureType.ValidationError:
        return (cause as PasscodeValidationFailure).displayableFailure();
    }
  }
}
