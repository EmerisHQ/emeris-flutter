import 'package:cosmos_utils/address_parser.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/balances_json.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/global.dart';

class EmerisBankRepository implements BankRepository {
  final Dio _dio;
  final BaseEnv _baseEnv;

  EmerisBankRepository(this._baseEnv, this._dio);

  @override
  Future<Either<GeneralFailure, List<Balance>>> getBalances(EmerisWallet walletData) async {
    final uri =
        '${_baseEnv.emerisBackendApiUrl}/v1/account/${bech32ToHex(walletData.walletDetails.walletAddress)}/balance';
    final response = await _dio.get(uri);
    final map = response.data as Map<String, dynamic>;
    final list = map['balances'] as List;
    return right(
      list
          .map((e) => BalanceJson.fromJson(e as Map<String, dynamic>))
          .toList()
          .where((element) => element.verified)
          .map((e) => e.toDomain(e))
          .toList(),
    );
  }
}