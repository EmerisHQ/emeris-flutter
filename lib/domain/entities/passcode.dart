import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/model/failures/passcode_validation_failure.dart';

class Passcode extends Equatable {
  const Passcode(
    this.value,
  );

  static const passcodeLength = 6;

  final String value;

  @override
  List<Object> get props => [
        value,
      ];

  PasscodeValidationFailure? validateError() {
    if (value.isEmpty) {
      return const PasscodeValidationFailure.empty();
    } else if (value.length < passcodeLength) {
      return const PasscodeValidationFailure.tooShort();
    } else if (value.length > passcodeLength) {
      return const PasscodeValidationFailure.tooLong();
    }
    return null;
  }
}
