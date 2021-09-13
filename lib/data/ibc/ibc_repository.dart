import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_app/data/model/verify_trace.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/base_ibc_respository.dart';

class IbcRepository implements BaseIbcRepository {
  IbcApi verifyTraceApi;

  IbcRepository({required this.verifyTraceApi});

  @override
  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainName, String hash) async =>
      verifyTraceApi.verifyTrace(chainName, hash);
}
