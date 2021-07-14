import 'package:equatable/equatable.dart';

class TransactionHash extends Equatable {
  final String hash;

  const TransactionHash({
    required this.hash,
  });

  @override
  List<Object> get props => [
        hash,
      ];
}
