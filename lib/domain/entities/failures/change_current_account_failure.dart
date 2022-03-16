import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GenerateCurrentAccountFailureType {
  Unknown,
}

class ChangeCurrentAccountFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ChangeCurrentAccountFailure.unknown([this.cause]) : _type = _GenerateCurrentAccountFailureType.Unknown;

  final _GenerateCurrentAccountFailureType _type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GenerateCurrentAccountFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'ChangeCurrentAccountFailure{_type: $_type, cause: $cause}';
  }
}
