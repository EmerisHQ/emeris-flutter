import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

class InvalidAmountFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const InvalidAmountFailure();

  DisplayableFailure displayableFailure() {
    return DisplayableFailure(
      title: '',
      message: strings.invalidAmountMessage,
    );
  }
}
