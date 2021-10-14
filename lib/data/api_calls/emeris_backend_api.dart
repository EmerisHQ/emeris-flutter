import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/balances_json.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/global.dart';

class EmerisBackendApi {
  final Dio _dio;
  final BaseEnv _baseEnv;

  EmerisBackendApi(this._dio, this._baseEnv);

  Future<Either<GeneralFailure, PaginatedList<Balance>>> getWalletBalances(String walletAddress) async {
    final uri = '${_baseEnv.emerisBackendApiUrl}/v1/account/$walletAddress/balance';
    final response = await _dio.get(uri);
    final map = response.data as Map<String, dynamic>;
    return right(PaginatedBalancesJson.fromJson(map).toDomain());
  }
}
