import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GenerateMnemonicFailureType {
  Unknown,
}

class GenerateMnemonicFailure {
  final _GenerateMnemonicFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const GenerateMnemonicFailure.unknown() : _type = _GenerateMnemonicFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GenerateMnemonicFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
