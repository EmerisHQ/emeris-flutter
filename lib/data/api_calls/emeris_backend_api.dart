import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/balances_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/global.dart';

class EmerisBackendApi {
  final Dio _dio;
  final BaseEnv _baseEnv;

  EmerisBackendApi(this._dio, this._baseEnv);

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
