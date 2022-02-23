import 'package:equatable/equatable.dart';

class FiatPair extends Equatable {
  const FiatPair({
    required this.ticker,
    required this.price,
  });

  final String ticker;
  final double price;

  @override
  List<Object?> get props => [
        ticker,
        price,
      ];
}
