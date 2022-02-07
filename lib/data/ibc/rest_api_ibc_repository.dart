import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/pool_json.dart';
import 'package:flutter_app/data/model/prices_data_json.dart';
import 'package:flutter_app/data/model/primary_channel_json.dart';
import 'package:flutter_app/data/model/translators/prices_translator.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/pool.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/primary_channel.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/entities/verify_trace.dart';
import 'package:flutter_app/domain/repositories/ibc_repository.dart';
import 'package:flutter_app/environment_config.dart';

class RestApiIbcRepository implements IbcRepository {
  RestApiIbcRepository(this._dio, this._baseEnv);

  final Dio _dio;
  final EnvironmentConfig _baseEnv;

  @override
  Future<Either<GeneralFailure, VerifyTrace>> verifyTrace(String chainId, String hash) async {
    try {
      final response = await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/chain/$chainId/denom/verify_trace/$hash');
      return right(VerifyTraceJson.fromJson((response.data as Map)['verify_trace'] as Map<String, dynamic>).toDomain());
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('error while verifying trace', ex, stack));
    }
  }

  @override
  Future<Either<GeneralFailure, List<VerifiedDenom>>> getVerifiedDenoms() async {
    try {
      final response = await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/verified_denoms');
      final denomsList = (response.data as Map)['verified_denoms'] as List;
      return right(
        denomsList.map((it) => VerifiedDenomJson.fromJson(it as Map<String, dynamic>).toDomain()).toList(),
      );
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('error while getting verified denoms', ex, stack));
    }
  }

  @override
  Future<Either<GeneralFailure, PrimaryChannel>> getPrimaryChannel({
    required String chainId,
    required String destinationChainId,
  }) async {
    try {
      final response =
          await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/chain/$chainId/primary_channel/$destinationChainId');
      return right(
        PrimaryChannelJson.fromJson((response.data as Map)['primary_channel'] as Map<String, dynamic>).toDomain(),
      );
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('error while getting primary channel', ex, stack));
    }
  }

  @override
  Future<Either<GeneralFailure, Price>> getPricesData() async {
    final uri = '${_baseEnv.emerisBackendApiUrl}/v1/oracle/prices';
    final response = await _dio.get(uri);
    final map = response.data as Map<String, dynamic>;
    return right(PricesDataJson.fromJson(map).toPrices());
  }

  @override
  Future<Either<GeneralFailure, List<Pool>>> getPools(EmerisWallet walletData) async {
    final uri = '${_baseEnv.emerisBackendApiUrl}/v1/liquidity/cosmos/liquidity/v1beta1/pools';
    final response = await _dio.get(uri);

    final map = response.data as Map<String, dynamic>;
    final pools = map['pools'] as List? ?? [];

    return right(
      pools.map((it) => PoolJson.fromJson(it as Map<String, dynamic>)).map((it) => it.toBalanceDomain()).toList(),
    );
  }
}
