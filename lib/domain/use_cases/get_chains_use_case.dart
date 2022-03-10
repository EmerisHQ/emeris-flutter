import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
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
        .doOn(success: (chains) => _metadataStore.chains = chains)
        .mapSuccess((_) => unit);
  }
}
