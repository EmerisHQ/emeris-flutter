import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/verified_denoms_json.dart';
import 'package:flutter_app/data/model/verify_trace.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:http/http.dart';

class IbcApi {
  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainName, String hash) async {
    final uri = Uri.parse('https://dev.demeris.io/v1/chain/$chainName/denom/verify_trace/$hash');
    final response = await Client().get(uri);
    return right(VerifyTraceJson.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
  }

  Future<Either<GeneralFailure, VerifiedDenomsJson>> getVerifiedDenoms() async {
    final uri = Uri.parse('https://dev.demeris.io/v1/verified_denoms');
    final response = await Client().get(uri);
    return right(VerifiedDenomsJson.fromJson(jsonDecode(response.body) as Map<String, dynamic>));

  }
}
