import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/http/http_service.dart';
import 'package:flutter_app/data/model/chain_json.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_chains_failure.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';

class RestApiChainsRepository extends ChainsRepository {
  RestApiChainsRepository(this._httpService);

  final HttpService _httpService;

  @override
  Future<Either<GetChainsFailure, List<Chain>>> getChains() async => _httpService
      .get('/v1/chains')
      .responseSubKey('chains')
      .executeList((json) => ChainJson.fromJson(json).toDomain())
      .mapError(GetChainsFailure.unknown);

  @override
  Future<Either<GeneralFailure, Chain>> getChainDetails(String chainId) async => _httpService
      .get('/v1/chain/$chainId')
      .responseSubKey('chain')
      .execute((json) => ChainJson.fromJson(json).toDomain())
      .mapError((fail) => GeneralFailure.unknown('Http failure', fail));
}
