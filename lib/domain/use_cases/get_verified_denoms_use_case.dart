import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/get_verified_denoms_failure.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';

class GetVerifiedDenomsUseCase {
  GetVerifiedDenomsUseCase(
    this._blockchainMetadataRepository,
    this._blockchainMetadataStore,
  );

  final BlockchainMetadataRepository _blockchainMetadataRepository;
  final BlockchainMetadataStore _blockchainMetadataStore;

  Future<Either<GetVerifiedDenomsFailure, Unit>> execute({bool forceLoadFromNetwork = true}) async {
    return _blockchainMetadataRepository
        .getVerifiedDenoms() //
        .doOn(
          success: (denoms) => _blockchainMetadataStore.denoms = denoms,
        )
        .mapSuccess((_) => unit);
  }
}
