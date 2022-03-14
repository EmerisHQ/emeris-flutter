import 'package:cosmos_utils/group_by_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';
import 'package:flutter_app/domain/use_cases/get_prices_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_verified_denoms_use_case.dart';

class GetBalancesUseCase {
  GetBalancesUseCase(
    this._bankRepository,
    this._getPricesUseCase,
    this._blockchainMetadataStore,
    this._getVerifiedDenomsUseCase,
  );

  final BankRepository _bankRepository;
  final GetPricesUseCase _getPricesUseCase;
  final BlockchainMetadataStore _blockchainMetadataStore;
  final GetVerifiedDenomsUseCase _getVerifiedDenomsUseCase;

  Future<Either<GeneralFailure, List<Balance>>> execute({
    required EmerisAccount accountData,
  }) async {
    await Future.wait([
      _getPricesUseCase.execute(),
      _getVerifiedDenomsUseCase.execute(),
    ]);
    final balanceList = await _bankRepository.getBalances(accountData);

    final verifiedDenoms = _blockchainMetadataStore.denoms;
    return balanceList.fold(
      (fail) => left(GeneralFailure.unknown(fail.message, fail.cause, fail.stack)),
      (balanceList) {
        final balances = balanceList
            .map(
              (it) => it.byUpdatingPriceAndVerifiedDenom(
                _blockchainMetadataStore.prices,
                verifiedDenoms,
              ),
            )
            .toList();
        return right(groupByDenom(balances));
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
