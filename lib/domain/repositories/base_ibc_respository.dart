import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/verify_trace.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';

abstract class BaseIbcRepository {
  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainName, String hash);
}
