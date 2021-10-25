import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';

class GetBalancesUseCase {
  final BankRepository _bankRepository;

  GetBalancesUseCase(this._bankRepository);

  Future<Either<GeneralFailure, AssetDetails>> execute({
    required EmerisWallet walletData,
  }) async =>
      _bankRepository.getBalances(walletData);
}
