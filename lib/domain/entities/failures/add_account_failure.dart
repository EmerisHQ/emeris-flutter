import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum AddAccountFailureType {
  Unknown,
  StoreError,
  InvalidMnemonic,
}

class AddAccountFailure {
  const AddAccountFailure.unknown({this.cause}) : _type = AddAccountFailureType.Unknown;

  const AddAccountFailure.storeError(this.cause) : _type = AddAccountFailureType.StoreError;

  const AddAccountFailure.invalidMnemonic(this.cause) : _type = AddAccountFailureType.InvalidMnemonic;

  final AddAccountFailureType _type;
  final Object? cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case AddAccountFailureType.Unknown:
      case AddAccountFailureType.StoreError:
      case AddAccountFailureType.InvalidMnemonic:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'AddAccountFailure{cause: $cause}';
  }
}
