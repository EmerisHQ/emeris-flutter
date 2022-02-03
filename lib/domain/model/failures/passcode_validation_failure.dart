import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

enum PasscodeValidationFailureType {
  Unknown,
  TooShort,
  TooLong,
  Empty,
}

class PasscodeValidationFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const PasscodeValidationFailure.unknown([this.cause]) : type = PasscodeValidationFailureType.Unknown;

  const PasscodeValidationFailure.tooShort([this.cause]) : type = PasscodeValidationFailureType.TooShort;

  const PasscodeValidationFailure.tooLong([this.cause]) : type = PasscodeValidationFailureType.TooLong;

  const PasscodeValidationFailure.empty([this.cause]) : type = PasscodeValidationFailureType.Empty;

  final PasscodeValidationFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case PasscodeValidationFailureType.Unknown:
        return DisplayableFailure.commonError();
      case PasscodeValidationFailureType.TooShort:
        return DisplayableFailure(
          title: '',
          message: strings.passcodeTooShort,
        );
      case PasscodeValidationFailureType.TooLong:
        return DisplayableFailure(
          title: '',
          message: strings.passcodeTooLong,
        );
      case PasscodeValidationFailureType.Empty:
        return DisplayableFailure(
          title: '',
          message: strings.passcodeIsEmpty,
        );
    }
  }

  @override
  String toString() {
    return 'PasscodeValidationFailure{type: $type, cause: $cause}';
  }
}
