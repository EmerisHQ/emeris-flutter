import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GeneralFailureType {
  Unknown,
}

class GeneralFailure {
  // ignore: avoid_field_initializers_in_const_classes
  GeneralFailure.unknown(this.message, [this.cause, this.stack]) : _type = _GeneralFailureType.Unknown {
    if (cause != null) {
      logError(cause, stack, message);
    }
  }

  final String message;
  final _GeneralFailureType _type;
  final Object? cause;
  final StackTrace? stack;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GeneralFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GeneralFailure{message: $message\ncause: $cause\nstack:\n$stack}';
}
