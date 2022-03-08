import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/pool.dart';

abstract class LiquidityPoolsRepository {
  Future<Either<GeneralFailure, List<Pool>>> getPools(EmerisAccount accountData);
}
