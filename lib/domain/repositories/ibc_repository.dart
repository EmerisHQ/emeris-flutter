import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/pool.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/primary_channel.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/entities/verify_trace.dart';

abstract class IbcRepository {
  Future<Either<GeneralFailure, VerifyTrace>> verifyTrace(String chainId, String hash);

  Future<Either<GeneralFailure, List<VerifiedDenom>>> getVerifiedDenoms();

  Future<Either<GeneralFailure, PrimaryChannel>> getPrimaryChannel({
    required String chainId,
    required String destinationChainId,
  });

  Future<Either<GeneralFailure, Chain>> getChainDetails(String chainId);

  Future<Either<GeneralFailure, Price>> getPricesData();

  Future<Either<GeneralFailure, List<Pool>>> getPools(EmerisWallet walletData);

  Future<Either<GeneralFailure, List<Chain>>> getChains();
}