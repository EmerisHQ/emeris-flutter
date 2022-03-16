import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum RenameAccountFailureType {
  Unknown,
  StoreError,
  InvalidMnemonic,
}

class RenameAccountFailure {
  const RenameAccountFailure.unknown({this.cause}) : _type = RenameAccountFailureType.Unknown;

  const RenameAccountFailure.storeError(this.cause) : _type = RenameAccountFailureType.StoreError;

  const RenameAccountFailure.invalidMnemonic(this.cause) : _type = RenameAccountFailureType.InvalidMnemonic;

  final RenameAccountFailureType _type;
  final Object? cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case RenameAccountFailureType.Unknown:
      case RenameAccountFailureType.StoreError:
      case RenameAccountFailureType.InvalidMnemonic:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'RenameAccountFailure{cause: $cause}';
  }
}
