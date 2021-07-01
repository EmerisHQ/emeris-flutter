import 'package:equatable/equatable.dart';

class WalletBalancesData extends Equatable {
  final String denom;
  final String amount;

  const WalletBalancesData({
    required this.amount,
    required this.denom,
  });

  @override
  List<Object> get props => [
        amount,
        denom,
      ];
}
