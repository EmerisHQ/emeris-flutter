import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum GetVerifiedDenomsFailureType {
  Unknown,
}

class GetVerifiedDenomsFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetVerifiedDenomsFailure.unknown([this.cause]) : type = GetVerifiedDenomsFailureType.Unknown;

  final GetVerifiedDenomsFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetVerifiedDenomsFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GetVerifiedDenomsFailure{type: $type, cause: $cause}';
  }
}
