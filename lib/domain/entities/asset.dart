import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

class Asset extends Equatable {
  const Asset({
    required this.verifiedDenom,
    required this.chainAssets,
  });

  final List<ChainAsset> chainAssets;
  final VerifiedDenom verifiedDenom;

  Denom get denom => verifiedDenom.denom;

  @override
  List<Object> get props => [
        verifiedDenom,
        chainAssets,
      ];

  Balance get totalBalance => Balance(
        denom: verifiedDenom.denom,
        amount: chainAssets.map((it) => it.balance).totalAmount,
      );
}

extension AssetIterableExtensions on Iterable<Asset> {
  String totalAmountInUSDText(Prices prices) => expand((element) => element.chainAssets) //
      .totalAmountInUSDText(prices);
}