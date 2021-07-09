import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/utils/logger.dart';

class GetBalancesUseCase {
  Future<Either<AddWalletFailure, PaginatedList<Balance>>> execute({required EmerisWallet walletData}) async {
    //TODO create fully-fledged wallet manager/repository for this
    try {
      final api = walletData.walletType == WalletType.Cosmos ? cosmosApi : ethApi;
      final response = await api.getWalletBalances(walletData.walletDetails.walletAddress);
      return right(response);
    } catch (e) {
      logError(e);
      return left(const AddWalletFailure.unknown());
    }
  }
}
