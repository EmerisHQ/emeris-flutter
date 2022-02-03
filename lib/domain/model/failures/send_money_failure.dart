import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum SendMoneyFailureType {
  Unknown,
}

class SendMoneyFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SendMoneyFailure.unknown([this.cause]) : type = SendMoneyFailureType.Unknown;

  final SendMoneyFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case SendMoneyFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'SendMoneyFailure{type: $type, cause: $cause}';
  }
}
