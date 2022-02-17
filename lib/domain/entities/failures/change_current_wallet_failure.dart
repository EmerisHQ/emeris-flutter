import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GenerateCurrentWalletFailureType {
  Unknown,
}

class ChangeCurrentWalletFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ChangeCurrentWalletFailure.unknown() : _type = _GenerateCurrentWalletFailureType.Unknown;

  final _GenerateCurrentWalletFailureType _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GenerateCurrentWalletFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
