import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

enum PasscodeFailureType {
  Unknown,
  PasscodesDontMatch,
}

class PasscodeFailure {
  final PasscodeFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const PasscodeFailure.unknown() : _type = PasscodeFailureType.Unknown;

  // ignore: avoid_field_initializers_in_const_classes
  const PasscodeFailure.passcodesDontMatch() : _type = PasscodeFailureType.PasscodesDontMatch;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case PasscodeFailureType.Unknown:
        return DisplayableFailure.commonError();
      case PasscodeFailureType.PasscodesDontMatch:
        return DisplayableFailure(
          title: strings.passcodeMatchFailureTitle,
          message: strings.passcodeMatchFailureMessage,
        );
    }
  }
}
