import 'package:cosmos_utils/address_parser.dart';
import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/http/http_service.dart';
import 'package:flutter_app/data/model/balance_json.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/data/model/staking_balance_json.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/staking_balance.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';

class EmerisBankRepository implements BankRepository {
  EmerisBankRepository(this._httpService, this._blockchainMetadataStore);

  final HttpService _httpService;
  final BlockchainMetadataStore _blockchainMetadataStore;

  @override
  Future<Either<GeneralFailure, List<Balance>>> getBalances(
    String accountAddress,
  ) async =>
      _httpService
          .get('/v1/account/${bech32ToHex(accountAddress)}/balance')
          .responseSubKey('balances')
          .executeList(BalanceJson.fromJson)
          .mapSuccess(
            (list) => list //
                .where((element) => element.verified ?? false)
                .map(_balanceToDomain)
                .toList(),
          )
          .mapError((fail) => GeneralFailure.unknown('Http failure', fail));

  Balance _balanceToDomain(BalanceJson json) {
    return json.toDomain(
      _blockchainMetadataStore.verifiedDenom(
            Denom.id(json.baseDenom ?? ''),
          ) ??
          const VerifiedDenom.empty(),
    );
  }

  @override
  Future<Either<GeneralFailure, List<StakingBalance>>> getStakingBalances(EmerisAccount accountData) async =>
      _httpService
          .get('/v1/account/${bech32ToHex(accountData.accountDetails.accountAddress.value)}/stakingbalances')
          .responseSubKey('staking_balances')
          .executeList((json) => StakingBalanceJson.fromJson(json).toDomain())
          .mapError((fail) => GeneralFailure.unknown('Http failure', fail));
}
