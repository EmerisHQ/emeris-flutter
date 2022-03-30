import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum DeleteAppDataFailureType {
  Unknown,
}

class DeleteAppDataFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteAppDataFailure.unknown([this.cause]) : type = DeleteAppDataFailureType.Unknown;

  final DeleteAppDataFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeleteAppDataFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'DeleteAppDataFailure{type: $type, cause: $cause}';
  }
}
