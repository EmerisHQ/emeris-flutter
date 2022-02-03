import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

class InvalidPasscodeFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const InvalidPasscodeFailure();

  DisplayableFailure displayableFailure() {
    return DisplayableFailure(
      title: '',
      message: strings.invalidPasscodeMessage,
    );
  }
}
