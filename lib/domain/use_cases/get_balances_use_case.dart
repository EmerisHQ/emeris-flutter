import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/domain/repositories/balances_repository.dart';

class GetBalancesUseCase {
  final BalancesRepository _balancesRepository;

  GetBalancesUseCase(this._balancesRepository);

  Future<Either<GeneralFailure, PaginatedList<Balance>>> execute({
    required EmerisWallet walletData,
  }) async =>
      _balancesRepository.getBalances(walletData);
}
