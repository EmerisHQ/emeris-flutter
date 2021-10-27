import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/chain_json.dart';
import 'package:flutter_app/data/model/primary_channel_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

abstract class IbcRepository {
  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainId, String hash);

  Future<Either<GeneralFailure, List<VerifiedDenom>>> getVerifiedDenoms();

  Future<Either<GeneralFailure, PrimaryChannelJson>> getPrimaryChannel({
    required String chainId,
    required String destinationChainId,
  });

  Future<Either<GeneralFailure, ChainJson>> getChainDetails(String chainId);

  Future<Either<GeneralFailure, Price>> getPricesData();
}
