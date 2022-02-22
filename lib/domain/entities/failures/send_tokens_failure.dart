import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum SendTokensFailureType {
  Unknown,
}

class SendTokensFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SendTokensFailure.unknown([this.cause]) : type = SendTokensFailureType.Unknown;

  final SendTokensFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case SendTokensFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'SendTokensFailure{type: $type, cause: $cause}';
  }
}
