import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

enum DeleteWalletFailureType {
  Unknown,
}

class DeleteWalletFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteWalletFailure.unknown({this.cause}) : _type = DeleteWalletFailureType.Unknown;

  final DeleteWalletFailureType _type;
  final Object? cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case DeleteWalletFailureType.Unknown:
        return DisplayableFailure(
          title: strings.verifyPasswordErrorTitle,
          message: strings.verifyPasswordErrorMessage,
        );
    }
  }

  @override
  String toString() {
    return 'DeleteWalletFailure{cause: $cause}';
  }
}
