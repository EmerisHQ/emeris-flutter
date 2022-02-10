import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/http/http_service.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/pool_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/pool.dart';
import 'package:flutter_app/domain/repositories/liquidity_pools_repository.dart';

class RestApiLiquidityPoolsRepository extends LiquidityPoolsRepository {
  RestApiLiquidityPoolsRepository(
    this._httpService,
  );

  final HttpService _httpService;

  @override
  Future<Either<GeneralFailure, List<Pool>>> getPools(EmerisWallet walletData) async {
    return _httpService
        .get('/v1/liquidity/cosmos/liquidity/v1beta1/pools')
        .responseSubKey('pools')
        .executeList((json) => PoolJson.fromJson(json).toBalanceDomain())
        .mapError((fail) => GeneralFailure.unknown('Http failure', fail));
  }
}
