import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/chain_asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/use_cases/get_chains_use_case.dart';

class GetChainAssetsUseCase {
  const GetChainAssetsUseCase(
    this._blockchainMetadataStore,
    this._getChainsUseCase,
  );

  final BlockchainMetadataStore _blockchainMetadataStore;
  final GetChainsUseCase _getChainsUseCase;

  Future<Either<GeneralFailure, List<ChainAsset>>> execute({
    required Denom baseDenom,
    required List<Balance> balances,
  }) async {
    return _getChainsUseCase
        .execute(forceLoadFromNetwork: false)
        .mapError((fail) => GeneralFailure.unknown('error getting chains', fail))
        .mapSuccess(
          (_) => _blockchainMetadataStore.chains
              .expand(
                (chain) => _matchBalancesWithChain(
                  _filterBalances(balances, baseDenom),
                  chain,
                ),
              )
              .toList(),
        );
  }

  Iterable<Balance> _filterBalances(List<Balance> balances, Denom baseDenom) {
    return balances.where(
      (it) => it.denom == baseDenom,
    );
  }

  Iterable<ChainAsset> _matchBalancesWithChain(
    Iterable<Balance> assetBalances,
    Chain chain,
  ) =>
      assetBalances //
          .where((balance) => chain.chainName == balance.onChain)
          .map(
            (balance) => ChainAsset(
              chain: chain,
              balance: balance,
            ),
          );
}
