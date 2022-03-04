import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum GetChainsFailureType {
  Unknown,
}

class GetChainsFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChainsFailure.unknown([this.cause]) : type = GetChainsFailureType.Unknown;

  final GetChainsFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChainsFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GetChainsFailure{type: $type, cause: $cause}';
  }
}
