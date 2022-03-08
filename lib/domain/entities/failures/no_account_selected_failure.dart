import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

class NoAccountSelectedFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const NoAccountSelectedFailure();

  DisplayableFailure displayableFailure() {
    return DisplayableFailure(
      title: strings.noAccountSelectedTitle,
      message: strings.noAccountSelectedMessage,
    );
  }
}
