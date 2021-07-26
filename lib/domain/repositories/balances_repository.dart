import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';

abstract class BalancesRepository {
  Future<Either<GeneralFailure, PaginatedList<Balance>>> getBalances(EmerisWallet walletData);
}
