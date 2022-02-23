import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/get_prices_failure.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';

class GetPricesUseCase {
  GetPricesUseCase(
    this._blockchainMetadataRepository,
    this._blockchainMetadataStore,
  );

  final BlockchainMetadataRepository _blockchainMetadataRepository;
  final BlockchainMetadataStore _blockchainMetadataStore;

  Future<Either<GetPricesFailure, Unit>> execute() async => _blockchainMetadataRepository.getPrices() //
          .mapSuccess(
        (prices) {
          _blockchainMetadataStore.prices = prices;
          return unit;
        },
      );
}
