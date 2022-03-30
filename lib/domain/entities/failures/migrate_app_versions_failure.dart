import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum MigrateAppVersionsFailureType {
  Unknown,
}

class MigrateAppVersionsFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const MigrateAppVersionsFailure.unknown() : _type = MigrateAppVersionsFailureType.Unknown;

  final MigrateAppVersionsFailureType _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case MigrateAppVersionsFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
