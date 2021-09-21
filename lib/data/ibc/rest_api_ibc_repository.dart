import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/ibc_respository.dart';

class RestApiIbcRepository implements IbcRepository {
  IbcApi ibcApi;

  RestApiIbcRepository({required this.ibcApi});

  @override
  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainId, String hash) async =>
      ibcApi.verifyTrace(chainId, hash);
}
