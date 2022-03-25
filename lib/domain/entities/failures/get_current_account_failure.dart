import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum GetCurrentAccountFailureType {
  Unknown,
  AccountNotFound,
}

class GetCurrentAccountFailure {
  const GetCurrentAccountFailure.unknown([this.cause]) : type = GetCurrentAccountFailureType.Unknown;

  const GetCurrentAccountFailure.accountNotFound(this.cause) : type = GetCurrentAccountFailureType.AccountNotFound;

  final GetCurrentAccountFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCurrentAccountFailureType.Unknown:
      case GetCurrentAccountFailureType.AccountNotFound:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'GetCurrentAccountFailure{type: $type, cause: $cause}';
  }
}
