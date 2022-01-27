import 'package:cosmos_utils/address_parser.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/balance_json.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/pool_json.dart';
import 'package:flutter_app/data/model/staking_balance_json.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/pool.dart';
import 'package:flutter_app/domain/entities/staking_balance.dart';
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
    final balanceList = map['balances'] as List;

    return right(
      balanceList
          .map((e) => BalanceJson.fromJson(e as Map<String, dynamic>))
          .toList()
          .where((element) => element.verified)
          .map((e) => e.toBalanceDomain())
          .toList(),
    );
  }

  @override
  Future<Either<GeneralFailure, List<StakingBalance>>> getStakingBalances(EmerisWallet walletData) async {
    final uri =
        '${_baseEnv.emerisBackendApiUrl}/v1/account/${bech32ToHex(walletData.walletDetails.walletAddress)}/stakingbalances';
    final response = await _dio.get(uri);
    final map = response.data as Map<String, dynamic>;
    final stakingBalanceList = map['staking_balances'] as List;

    return right(
      stakingBalanceList
          .map((it) => StakingBalanceJson.fromJson(it as Map<String, dynamic>))
          .map((it) => it.toDomain())
          .toList(),
    );
  }

  @override
  Future<Either<GeneralFailure, List<Pool>>> getPools(EmerisWallet walletData) async {
    final uri = '${_baseEnv.emerisBackendApiUrl}/v1/liquidity/cosmos/liquidity/v1beta1/pools';
    final response = await _dio.get(uri);
    final map = response.data as Map<String, dynamic>;
    final pools = map['pools'] as List;

    return right(
      pools.map((it) => PoolJson.fromJson(it as Map<String, dynamic>)).map((it) => it.toBalanceDomain()).toList(),
    );
  }
}
