import 'package:equatable/equatable.dart';

class Pool extends Equatable {
  const Pool({
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

  @override
  List<Object?> get props => [
        id,
        typeId,
        reserveCoinDenoms,
        reserveAccountAddress,
        poolCoinDenom,
      ];
}
