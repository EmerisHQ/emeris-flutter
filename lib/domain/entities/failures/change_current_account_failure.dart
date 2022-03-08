import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GenerateCurrentAccountFailureType {
  Unknown,
}

class ChangeCurrentAccountFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ChangeCurrentAccountFailure.unknown() : _type = _GenerateCurrentAccountFailureType.Unknown;

  final _GenerateCurrentAccountFailureType _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GenerateCurrentAccountFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
