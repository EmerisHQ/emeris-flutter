import 'package:equatable/equatable.dart';

class GasPriceLevels extends Equatable {
  const GasPriceLevels({
    required this.low,
    required this.average,
    required this.high,
  });

  const GasPriceLevels.empty()
      : low = 0.0,
        average = 0.0,
        high = 0.0;

  final double low;
  final double average;
  final double high;

  @override
  List<Object?> get props => [
        low,
        average,
        high,
      ];
}
