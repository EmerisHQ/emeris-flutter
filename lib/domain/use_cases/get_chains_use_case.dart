import 'package:cosmos_utils/extensions.dart';
import 'package:cosmos_utils/future_either.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/failures/get_chains_failure.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';

class GetChainsUseCase {
  GetChainsUseCase(this._chainsRepository, this._metadataStore);

  final ChainsRepository _chainsRepository;
  final BlockchainMetadataStore _metadataStore;

  Future<Either<GetChainsFailure, Unit>> execute({bool forceLoadFromNetwork = true}) async {
    if (!forceLoadFromNetwork && _metadataStore.chains.isNotEmpty) {
      return right(unit);
    }
    return _chainsRepository
        .getChains() //
        .flatMap(_downloadDetails)
        .doOn(success: (details) => _metadataStore.chains = details)
        .mapSuccess((_) => unit);
  }

  Future<Either<GetChainsFailure, List<Chain>>> _downloadDetails(List<Chain> chains) async {
    {
      final detailsResults = await Future.wait(
        chains.map((chain) => _chainsRepository.getChainDetails(chain.chainName)),
      );
      final errors = detailsResults.where((element) => element.isLeft());
      if (errors.isNotEmpty) {
        return left(GetChainsFailure.unknown(errors));
      }
      return right(
        detailsResults //
            .map((result) => result.getOrElse(Chain.empty))
            .toList(),
      );
    }
  }
}
