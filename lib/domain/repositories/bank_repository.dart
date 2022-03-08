import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/staking_balance.dart';

abstract class BankRepository {
  Future<Either<GeneralFailure, List<Balance>>> getBalances(EmerisAccount accountData);

  Future<Either<GeneralFailure, List<StakingBalance>>> getStakingBalances(EmerisAccount accountData);
}
