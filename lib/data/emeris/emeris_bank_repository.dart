import 'package:cosmos_utils/address_parser.dart';
import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/http/http_service.dart';
import 'package:flutter_app/data/model/balance_json.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/staking_balance_json.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/staking_balance.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';

class EmerisBankRepository implements BankRepository {
  EmerisBankRepository(this._httpService);

  final HttpService _httpService;

  @override
  Future<Either<GeneralFailure, List<Balance>>> getBalances(EmerisWallet walletData) async => _httpService
      .get('/v1/account/${bech32ToHex(walletData.walletDetails.walletAddress)}/balance')
      .responseSubKey('balances')
      .executeList(BalanceJson.fromJson)
      .mapSuccess(
        (list) => list //
            .where((element) => element.verified ?? false)
            .map((e) => e.toBalanceDomain())
            .toList(),
      )
      .mapError((fail) => GeneralFailure.unknown('Http failure', fail));

  @override
  Future<Either<GeneralFailure, List<StakingBalance>>> getStakingBalances(EmerisWallet walletData) async => _httpService
      .get('/v1/account/${bech32ToHex(walletData.walletDetails.walletAddress)}/stakingbalances')
      .responseSubKey('staking_balances')
      .executeList((json) => StakingBalanceJson.fromJson(json).toDomain())
      .mapError((fail) => GeneralFailure.unknown('Http failure', fail));
}
