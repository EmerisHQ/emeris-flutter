import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/asset_chain.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/ibc_repository.dart';

class GetAssetChainsUseCase {
  GetAssetChainsUseCase(this._ibcRepository);

  final IbcRepository _ibcRepository;

  Future<Either<GeneralFailure, List<AssetChain>>> execute({
    required Denom baseDenom,
    required List<Balance> balances,
  }) =>
      _ibcRepository.getChains().mapSuccess((chains) {
        final assetChains = <AssetChain>[];
        final assetBalances = balances.where((it) => it.denom == baseDenom);
        for (final chain in chains) {
          for (final balance in assetBalances) {
            if (chain.chainName == balance.onChain) {
              assetChains.add(AssetChain(chainDetails: chain, balance: balance));
            }
          }
        }

        return assetChains;
      });
}
