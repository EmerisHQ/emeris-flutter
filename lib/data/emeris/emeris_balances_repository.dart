import 'package:cosmos_utils/address_parser.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/emeris_backend_api.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/balances_repository.dart';

class EmerisBalancesRepository implements BalancesRepository {
  final EmerisBackendApi _emerisBackendApi;

  EmerisBalancesRepository(this._emerisBackendApi);

  @override
  Future<Either<GeneralFailure, List<Balance>>> getBalances(EmerisWallet walletData) async =>
      _emerisBackendApi.getWalletBalances(bech32ToHex(walletData.walletDetails.walletAddress));
}
