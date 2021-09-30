import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _TransferFailureType {
  VerifyTrace,
  PrimaryChannel,
  DenomRedemption,
}

class TransferFailure {
  final Object? cause;
  final _TransferFailureType _type;

  // ignore: avoid_field_initializers_in_const_classes
  const TransferFailure.verifyTraceError(this.cause) : _type = _TransferFailureType.VerifyTrace;

  const TransferFailure.primaryChannelError(this.cause) : _type = _TransferFailureType.PrimaryChannel;

  const TransferFailure.denomRedemptionError(this.cause) : _type = _TransferFailureType.DenomRedemption;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _TransferFailureType.VerifyTrace:
      case _TransferFailureType.PrimaryChannel:
      case _TransferFailureType.DenomRedemption:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'TransferFailure{cause: $cause}';
  }
}
