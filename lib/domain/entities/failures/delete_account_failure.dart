import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

enum DeleteAccountFailureType {
  Unknown,
}

class DeleteAccountFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteAccountFailure.unknown({this.cause}) : _type = DeleteAccountFailureType.Unknown;

  final DeleteAccountFailureType _type;
  final Object? cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case DeleteAccountFailureType.Unknown:
        return DisplayableFailure(
          title: strings.verifyPasswordErrorTitle,
          message: strings.verifyPasswordErrorMessage,
        );
    }
  }

  @override
  String toString() {
    return 'DeleteAccountFailure{cause: $cause}';
  }
}
