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
  }) async {
    final stakingBalances = await _bankRepository.getStakingBalances(wallet);
    return stakingBalances.fold(
      left,
      (r) {
        final amountListOnChain = r.where((element) => element.chainName == onChain).toList();
        var amount = 0.0;
        for (final element in amountListOnChain) {
          amount += element.amount.value.toDouble();
        }
        return right(Amount.fromString(amount.toString()));
      },
    );
  }
}
