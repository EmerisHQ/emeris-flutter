import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/stores/assets_store.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/use_cases/get_prices_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_verified_denoms_use_case.dart';

class GetBalancesUseCase {
  GetBalancesUseCase(
    this._bankRepository,
    this._getPricesUseCase,
    this._blockchainMetadataStore,
    this._getVerifiedDenomsUseCase,
    this._assetsStore,
  );

  final BankRepository _bankRepository;
  final GetPricesUseCase _getPricesUseCase;
  final BlockchainMetadataStore _blockchainMetadataStore;
  final GetVerifiedDenomsUseCase _getVerifiedDenomsUseCase;
  final AssetsStore _assetsStore;

  Future<Either<GeneralFailure, Unit>> execute({
    required AccountDetails details,
  }) async {
    await Future.wait([
      _getPricesUseCase.execute(forceLoadFromNetwork: false),
      _getVerifiedDenomsUseCase.execute(forceLoadFromNetwork: false),
    ]);
    return _bankRepository
        .getBalances(
          details.accountAddress,
        )
        .doOn(success: (it) => _updateAssetsStore(details, it))
        .mapSuccess((response) => unit);
  }

  void _updateAssetsStore(AccountDetails details, List<Balance> it) {
    return _assetsStore.updateAssets(
      details.accountIdentifier,
      it.groupIntoAssets(
        _blockchainMetadataStore,
      ),
    );
  }
}
