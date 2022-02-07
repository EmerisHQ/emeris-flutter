import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/pool_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/pool.dart';
import 'package:flutter_app/domain/repositories/liquidity_pools_repository.dart';
import 'package:flutter_app/environment_config.dart';

class RestApiLiquidityPoolsRepository extends LiquidityPoolsRepository {
  RestApiLiquidityPoolsRepository(this._dio, this._baseEnv);

  final Dio _dio;
  final EnvironmentConfig _baseEnv;

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
