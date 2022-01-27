class Pool {
  Pool({
    required this.id,
    required this.typeId,
    required this.reserveCoinDenoms,
    required this.reserveAccountAddress,
    required this.poolCoinDenom,
  });

  final String id;
  final int typeId;
  final List<String> reserveCoinDenoms;
  final String reserveAccountAddress;
  final String poolCoinDenom;
}
