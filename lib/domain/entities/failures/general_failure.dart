import 'package:emeris_app/domain/entities/failures/displayable_failure.dart';

enum _GeneralFailureType {
  Unknown,
}

class GeneralFailure {
  final String message;
  final _GeneralFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const GeneralFailure.unknown(this.message) : _type = _GeneralFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GeneralFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GeneralFailure($message)';
  }
}
