import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';

class GetStakedAmountUseCase {
  GetStakedAmountUseCase(this._bankRepository);

  final BankRepository _bankRepository;

  Future<Either<GeneralFailure, Amount>> execute({
    required EmerisAccount account,
  }) =>
      _bankRepository.getStakingBalances(account).mapSuccess((balances) {
        final amountDecimal = balances.map((e) => e.amount.value).reduce((a, b) => a + b);
        return Amount(amountDecimal);
      });
}
