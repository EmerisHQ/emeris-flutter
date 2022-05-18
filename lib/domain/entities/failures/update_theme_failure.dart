import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum UpdateThemeFailureType {
  Unknown,
}

class UpdateThemeFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateThemeFailure.unknown([this.cause]) : type = UpdateThemeFailureType.Unknown;

  final UpdateThemeFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateThemeFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'UpdateThemeFailure{type: , cause: }';
  }
}
