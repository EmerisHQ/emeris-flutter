import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/primary_channel_json.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';

class IbcApi {
  final Dio _dio;

  IbcApi(this._dio);

  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainId, String hash) async {
    try {
      final response = await _dio.get('https://dev.demeris.io/v1/chain/$chainId/denom/verify_trace/$hash');
      return right(VerifyTraceJson.fromJson((response.data as Map)['verify_trace'] as Map<String, dynamic>));
    } catch (ex, stack) {
      return left(GeneralFailure.unknown("error while verifying trace", ex, stack));
    }
  }

  Future<Either<GeneralFailure, List<VerifiedDenomJson>>> getVerifiedDenoms() async {
    try {
      final response = await _dio.get('https://dev.demeris.io/v1/verified_denoms');
      final denomsList = (response.data as Map)['verified_denoms'] as List;
      return right(
        denomsList.map((it) => VerifiedDenomJson.fromJson(it as Map<String, dynamic>)).toList(),
      );
    } catch (ex, stack) {
      return left(GeneralFailure.unknown("error while getting verified denoms", ex, stack));
    }
  }

  Future<Either<GeneralFailure, PrimaryChannelJson>> getPrimaryChannel({
    required String chainId,
    required String destinationChanName,
  }) async {
    try {
      final response = await _dio.get('https://dev.demeris.io/v1/chain/$chainId/primary_channel/$destinationChanName');
      return right(PrimaryChannelJson.fromJson((response.data as Map)['primary_channel'] as Map<String, dynamic>));
    } catch (ex, stack) {
      return left(GeneralFailure.unknown("error while getting primary channel", ex, stack));
    }
  }
}
