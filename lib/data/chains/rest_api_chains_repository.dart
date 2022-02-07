import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/chain_details_json.dart';
import 'package:flutter_app/data/model/chain_json.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/environment_config.dart';

class RestApiChainsRepository extends ChainsRepository {
  RestApiChainsRepository(this._dio, this._baseEnv);

  final Dio _dio;
  final EnvironmentConfig _baseEnv;

  @override
  Future<Either<GeneralFailure, List<Chain>>> getChains() async {
    final uri = '${_baseEnv.emerisBackendApiUrl}/v1/chains';
    final response = await _dio.get(uri);

    final map = response.data as Map<String, dynamic>;
    final chains = map['chains'] as List? ?? [];

    return right(
      chains.map((it) => ChainDetailsJson.fromJson(it as Map<String, dynamic>)).map((it) => it.toDomain()).toList(),
    );
  }

  @override
  Future<Either<GeneralFailure, Chain>> getChainDetails(String chainId) async {
    try {
      final response = await _dio.get('${_baseEnv.emerisBackendApiUrl}/v1/chain/$chainId');
      return right(ChainJson.fromJson((response.data as Map)['chain'] as Map<String, dynamic>).toDomain());
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('Error while getting chain details', ex, stack));
    }
  }
}
