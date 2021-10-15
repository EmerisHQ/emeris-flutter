import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/balances_json.dart';
import 'package:flutter_app/data/model/chain_json.dart';
import 'package:flutter_app/data/model/primary_channel_json.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/global.dart';

class EmerisBackendApi {
  final Dio _dio;
  final BaseEnv _baseEnv;

  EmerisBackendApi(this._dio, this._baseEnv);

  Future<Either<GeneralFailure, VerifyTraceJson>> verifyTrace(String chainId, String hash) async {
    try {
      final response = await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/chain/$chainId/denom/verify_trace/$hash');
      return right(VerifyTraceJson.fromJson((response.data as Map)['verify_trace'] as Map<String, dynamic>));
    } catch (ex, stack) {
      return left(GeneralFailure.unknown("error while verifying trace", ex, stack));
    }
  }

  Future<Either<GeneralFailure, List<VerifiedDenomJson>>> getVerifiedDenoms() async {
    try {
      final response = await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/verified_denoms');
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
    required String destinationChainId,
  }) async {
    try {
      final response =
          await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/chain/$chainId/primary_channel/$destinationChainId');
      return right(PrimaryChannelJson.fromJson((response.data as Map)['primary_channel'] as Map<String, dynamic>));
    } catch (ex, stack) {
      return left(GeneralFailure.unknown("error while getting primary channel", ex, stack));
    }
  }

  Future<Either<GeneralFailure, ChainJson>> getChainDetails(String chainId) async {
    try {
      final response = await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/chain/$chainId');
      return right(ChainJson.fromJson((response.data as Map)['chain'] as Map<String, dynamic>));
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('Error while getting chain details', ex, stack));
    }
  }

  Future<Either<GeneralFailure, List<Balance>>> getWalletBalances(String walletAddress) async {
    final uri = '${_baseEnv.emerisBackendApiUrl}/v1/account/$walletAddress/balance';
    final response = await _dio.get(uri);
    final map = response.data as Map<String, dynamic>;
    final list = map['balances'] as List;
    return right(_toDomain(list));
  }

  List<Balance> _toDomain(List<dynamic> list) {
    return list
        .map((e) => BalanceJson.fromJson(e as Map<String, dynamic>))
        .where((element) => element.verified)
        .map(
          (it) => Balance(
            denom: Denom(it.baseDenom),
            amount: Amount.fromString(it.amount.split('/')[0].replaceAll(it.baseDenom, '').replaceAll('ibc', '')),
          ),
        )
        .toList();
  }
}
