import 'package:cosmos_utils/group_by_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/use_cases/get_prices_use_case.dart';

class GetBalancesUseCase {
  GetBalancesUseCase(
    this._bankRepository,
    this._blockchainMetadataRepository,
    this._getPricesUseCase,
    this._blockchainMetadataStore,
  );

  final BankRepository _bankRepository;
  final BlockchainMetadataRepository _blockchainMetadataRepository;
  final GetPricesUseCase _getPricesUseCase;
  final BlockchainMetadataStore _blockchainMetadataStore;

  Future<Either<GeneralFailure, AssetDetails>> execute({
    required EmerisAccount accountData,
  }) async {
    await _getPricesUseCase.execute();
    final balanceList = await _bankRepository.getBalances(accountData);

    final prices = _blockchainMetadataStore.prices;

    final verifiedDenoms = await _blockchainMetadataRepository.getVerifiedDenoms();
    return verifiedDenoms.fold(
      (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
      (verifiedDenoms) async {
        return balanceList.fold(
          (fail) => left(GeneralFailure.unknown(fail.message, fail.cause, fail.stack)),
          (balanceList) {
            final balances = balanceList
                .map(
                  (it) => it.byUpdatingPriceAndVerifiedDenom(
                    prices,
                    verifiedDenoms,
                  ),
                )
                .toList();
            return right(AssetDetails(balances: groupByDenom(balances)));
          },
        );
      },
    );
  }

  List<Balance> groupByDenom(List<Balance> balances) => balances
      .groupBy((obj) => obj.denom)
      .map(
        (key, denomBalances) => MapEntry(
          key,
          denomBalances.first.copyWith(
            amount: denomBalances.totalAmount,
          ),
        ),
      )
      .values
      .toList();
}
