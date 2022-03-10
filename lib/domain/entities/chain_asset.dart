import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain.dart';

class ChainAsset extends Equatable {
  const ChainAsset({
    required this.chain,
    required this.balance,
  });

  final Balance balance;
  final Chain chain;

  @override
  // TODO: implement props
  List<Object?> get props => [
        balance,
        chain,
      ];
}
