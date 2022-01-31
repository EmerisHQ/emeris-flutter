import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';

enum _RedeemFailureTyre {
  VerifyTrace,
  BuildStep,
}

class RedeemFailure {
  const RedeemFailure.verifyTraceError(this.cause) : _type = _RedeemFailureTyre.VerifyTrace;

  const RedeemFailure.buildStepError(this.cause) : _type = _RedeemFailureTyre.BuildStep;

  final Object? cause;
  final _RedeemFailureTyre _type;

  DisplayableFailure displayableFailure() {
    switch (_type) {
      case _RedeemFailureTyre.VerifyTrace:
      case _RedeemFailureTyre.BuildStep:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() {
    return 'RedeemFailure{cause: $cause}';
  }
}
