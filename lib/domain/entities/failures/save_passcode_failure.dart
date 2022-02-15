import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/domain/entities/failures/passcode_validation_failure.dart';

enum SavePasscodeFailureType {
  Unknown,
  ValidationError,
}

class SavePasscodeFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SavePasscodeFailure.unknown([this.cause]) : type = SavePasscodeFailureType.Unknown;

  const SavePasscodeFailure.validationError(PasscodeValidationFailure failure)
      : cause = failure,
        type = SavePasscodeFailureType.ValidationError;

  final SavePasscodeFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case SavePasscodeFailureType.Unknown:
        return DisplayableFailure.commonError();
      case SavePasscodeFailureType.ValidationError:
        return (cause as PasscodeValidationFailure).displayableFailure();
    }
  }

  @override
  String toString() {
    return 'SavePasscodeFailure{type: $type, cause: $cause}';
  }
}
