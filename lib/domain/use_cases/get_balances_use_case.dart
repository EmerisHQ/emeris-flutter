import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/ibc_respository.dart';

class GetBalancesUseCase {
  final BankRepository _bankRepository;
  final IbcRepository _ibcRepository;

  GetBalancesUseCase(this._bankRepository, this._ibcRepository);

  Future<Either<GeneralFailure, AssetDetails>> execute({
    required EmerisWallet walletData,
  }) async {
    final balanceList = await _bankRepository.getBalances(walletData);
    final prices = await _ibcRepository.getPricesData();
    return prices.fold(
      (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
      (prices) async {
        final verifiedDenoms = await _ibcRepository.getVerifiedDenoms();
        return verifiedDenoms.fold(
          (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
          (verifiedDenoms) async {
            return balanceList.fold((l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)), (r) {
              final balances = r.map((e) => e.toDomain(e, prices, verifiedDenoms)).toList();
              return right(
                AssetDetails(balances: balances),
              );
            });
          },
        );
      },
    );
  }
}
