import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum ShareDataFailureType {
  Unknown,
}

class ShareDataFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ShareDataFailure.unknown([this.cause]) : type = ShareDataFailureType.Unknown;

  final ShareDataFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case ShareDataFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'ShareDataFailure{type: , cause: }';
  }
}
