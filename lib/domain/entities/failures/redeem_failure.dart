class RedeemFailure {
  final Object? cause;

  const RedeemFailure.verifyTraceError(this.cause);

  @override
  String toString() {
    return 'RedeemFailure{cause: $cause}';
  }
}
