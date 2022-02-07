import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/pool.dart';

abstract class LiquidityPoolsRepository {
  Future<Either<GeneralFailure, List<Pool>>> getPools(EmerisWallet walletData);
}
