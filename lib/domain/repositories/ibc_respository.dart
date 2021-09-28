import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';

abstract class IbcRepository {
  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainId, String hash);
}
