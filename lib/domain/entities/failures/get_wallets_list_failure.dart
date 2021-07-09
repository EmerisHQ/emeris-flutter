import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GetWalletsListFailureType {
  Unknown,
}

class GetWalletsListFailure {
  final _GetWalletsListFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const GetWalletsListFailure.unknown() : _type = _GetWalletsListFailureType.Unknown;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GetWalletsListFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
    throw StateError("Cannot parse $_type into DisplayableFailure");
  }
}
