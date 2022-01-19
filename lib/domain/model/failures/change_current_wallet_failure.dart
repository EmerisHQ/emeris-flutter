import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GenerateCurrentWalletFailureType {
  Unknown,
}

class ChangeCurrentWalletFailure {
  final _GenerateCurrentWalletFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const ChangeCurrentWalletFailure.unknown() : _type = _GenerateCurrentWalletFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GenerateCurrentWalletFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
