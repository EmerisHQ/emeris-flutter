import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum AddWalletFailureType {
  Unknown,
  StoreError,
  InvalidMnemonic,
}

class AddWalletFailure {
  const AddWalletFailure.unknown({this.cause}) : _type = AddWalletFailureType.Unknown;

  const AddWalletFailure.storeError(this.cause) : _type = AddWalletFailureType.StoreError;

  const AddWalletFailure.invalidMnemonic(this.cause) : _type = AddWalletFailureType.InvalidMnemonic;

  final AddWalletFailureType _type;
  final Object? cause;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case AddWalletFailureType.Unknown:
      case AddWalletFailureType.StoreError:
      case AddWalletFailureType.InvalidMnemonic:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'AddWalletFailure{cause: $cause}';
  }
}
