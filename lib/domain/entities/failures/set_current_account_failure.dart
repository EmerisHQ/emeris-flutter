import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum SetCurrentAccountFailureType {
  Unknown,
  AccountNotFound,
}

class SetCurrentAccountFailure {
  const SetCurrentAccountFailure.unknown([this.cause]) : type = SetCurrentAccountFailureType.Unknown;

  const SetCurrentAccountFailure.accountNotFound(this.cause) : type = SetCurrentAccountFailureType.AccountNotFound;

  final SetCurrentAccountFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case SetCurrentAccountFailureType.Unknown:
      case SetCurrentAccountFailureType.AccountNotFound:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'UpdateAdditionalAccountDataFailure{type: $type, cause: $cause}';
  }
}
