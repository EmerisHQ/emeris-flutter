import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _GetAccountsListFailureType {
  Unknown,
}

class GetAccountsListFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetAccountsListFailure.unknown() : _type = _GetAccountsListFailureType.Unknown;

  final _GetAccountsListFailureType _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _GetAccountsListFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }
}
