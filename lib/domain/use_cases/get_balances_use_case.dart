import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/model/failures/add_wallet_failure.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/utils/logger.dart';

class GetBalancesUseCase {
  Future<Either<AddWalletFailure, List<Balance>>> execute({required EmerisWallet walletData}) async {
    //TODO create fully-fledged wallet manager/repository for this
    try {
      final api = walletData.walletType == WalletType.Cosmos ? cosmosApi : ethApi;
      final response = await api.getWalletBalances(walletData.walletDetails.walletAddress);
      final balances = response.list
          .map(
            (e) => Balance(
              amount: e.amount,
              denom: e.denom,
            ),
          )
          .toList();
      return right(balances);
    } catch (e) {
      logError(e);
      return left(const AddWalletFailure.unknown());
    }
  }
}
