import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';

class GetStakedAmountUseCase {
  GetStakedAmountUseCase(this._bankRepository);

  final BankRepository _bankRepository;

  Future<Either<GeneralFailure, Amount>> execute({
    required EmerisWallet wallet,
    required String onChain,
  }) =>
      _bankRepository.getStakingBalances(wallet).mapSuccess((balances) {
        final amountDecimal = balances
            .where((element) => element.chainName == onChain)
            .map((e) => e.amount.value)
            .reduce((a, b) => a + b);
        return Amount(amountDecimal);
      });
}
