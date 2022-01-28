import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GenerateMnemonicFailureType {
  Unknown,
}

class GenerateMnemonicFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GenerateMnemonicFailure.unknown() : _type = _GenerateMnemonicFailureType.Unknown;

  final _GenerateMnemonicFailureType _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GenerateMnemonicFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
