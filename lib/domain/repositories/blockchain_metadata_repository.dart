import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_prices_failure.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/primary_channel.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/entities/verify_trace.dart';

abstract class BlockchainMetadataRepository {
  Future<Either<GeneralFailure, VerifyTrace>> verifyTrace(String chainId, String hash);

  Future<Either<GeneralFailure, List<VerifiedDenom>>> getVerifiedDenoms();

  Future<Either<GeneralFailure, PrimaryChannel>> getPrimaryChannel({
    required String chainId,
    required String destinationChainId,
  });

  Future<Either<GetPricesFailure, Prices>> getPrices();
}
