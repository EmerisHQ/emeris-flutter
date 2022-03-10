import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum AppInitFailureType {
  Unknown,
}

class AppInitFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AppInitFailure.unknown([this.cause]) : type = AppInitFailureType.Unknown;

  final AppInitFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case AppInitFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'AppInitFailure{type: $type, cause: $cause}';
  }
}
