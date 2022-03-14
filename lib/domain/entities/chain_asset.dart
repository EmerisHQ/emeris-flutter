import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

class ChainAsset extends Equatable {
  const ChainAsset({
    required this.chain,
    required this.verifiedDenom,
    required this.balance,
  });

  ChainAsset.empty()
      : chain = const Chain.empty(),
        verifiedDenom = const VerifiedDenom.empty(),
        balance = Balance.empty();

  final Chain chain;
  final VerifiedDenom verifiedDenom;
  final Balance balance;

  Denom get denom => balance.denom;

  @override
  List<Object?> get props => [
        chain,
        verifiedDenom,
        balance,
      ];

  ChainAsset copyWith({
    Chain? chain,
    VerifiedDenom? verifiedDenom,
    Balance? balance,
  }) {
    return ChainAsset(
      chain: chain ?? this.chain,
      verifiedDenom: verifiedDenom ?? this.verifiedDenom,
      balance: balance ?? this.balance,
    );
  }
}

extension ChainAssetIterableExtensions on Iterable<ChainAsset> {
  String totalAmountInUSDText(Prices prices) => map((it) => it.balance) //
      .totalAmountInUSDText(prices);
}
