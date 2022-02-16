import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';

class GetBalancesUseCase {
  GetBalancesUseCase(this._bankRepository, this._blockchainMetadataRepository);

  final BankRepository _bankRepository;
  final BlockchainMetadataRepository _blockchainMetadataRepository;

  Future<Either<GeneralFailure, AssetDetails>> execute({
    required EmerisWallet walletData,
  }) async {
    final balanceList = await _bankRepository.getBalances(walletData);
    final prices = await _blockchainMetadataRepository.getPricesData();
    return prices.fold(
      (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
      (prices) async {
        final verifiedDenoms = await _blockchainMetadataRepository.getVerifiedDenoms();
        return verifiedDenoms.fold(
          (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
          (verifiedDenoms) async {
            return balanceList.fold(
              (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
              (r) {
                final balances = r.map((it) => it.byUpdatingPriceAndVerifiedDenom(prices, verifiedDenoms)).toList();
                return right(
                  AssetDetails(balances: balances),
                );
              },
            );
          },
        );
      },
    );
  }
}
