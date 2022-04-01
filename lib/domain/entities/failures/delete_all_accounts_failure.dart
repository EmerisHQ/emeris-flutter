import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum DeleteAllAccountsFailureType {
  Unknown,
}

class DeleteAllAccountsFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteAllAccountsFailure.unknown([this.cause]) : type = DeleteAllAccountsFailureType.Unknown;

  final DeleteAllAccountsFailureType type;
  final dynamic cause;

  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeleteAllAccountsFailureType.Unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'DeleteAllAccountsFailure{type: $type, cause: $cause}';
  }
}
