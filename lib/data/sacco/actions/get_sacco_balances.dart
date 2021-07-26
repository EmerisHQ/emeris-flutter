import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/balances_json.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/global.dart';

Future<Either<GeneralFailure, PaginatedList<Balance>>> getSaccoBalances(
    BaseEnv baseEnv, Dio dio, String walletAddress) async {
  final uri = '${baseEnv.baseApiUrl}/cosmos/bank/v1beta1/balances/$walletAddress';
  final response = await dio.get(uri);
  final map = response.data as Map<String, dynamic>;
  return right(PaginatedBalancesJson.fromJson(map).toDomain());
}
