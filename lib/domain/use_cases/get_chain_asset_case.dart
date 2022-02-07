import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/asset_chain.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/ibc_repository.dart';

class GetChainAssetUseCase {
  GetChainAssetUseCase(this._ibcRepository);

  final IbcRepository _ibcRepository;

  Future<Either<GeneralFailure, List<ChainAsset>>> execute({
    required Denom baseDenom,
    required List<Balance> balances,
  }) =>
      _ibcRepository //
          .getChains()
          .mapSuccess(
        (chains) {
          final filteredBalances = balances.where(
            (it) => it.denom == baseDenom,
          );
          return chains //
              .expand((chain) => _matchBalancesWithChain(filteredBalances, chain))
              .toList();
        },
      );

  Iterable<ChainAsset> _matchBalancesWithChain(
    Iterable<Balance> assetBalances,
    Chain chain,
  ) =>
      assetBalances //
          .where((balance) => chain.chainName == balance.onChain)
          .map(
            (balance) => ChainAsset(
              chainDetails: chain,
              balance: balance,
            ),
          );
}
