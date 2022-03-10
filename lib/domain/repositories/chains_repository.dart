import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_chains_failure.dart';

abstract class ChainsRepository {
  Future<Either<GetChainsFailure, List<Chain>>> getChains();

  Future<Either<GeneralFailure, Chain>> getChainDetails(String chainId);
}
