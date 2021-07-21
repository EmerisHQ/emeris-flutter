import 'package:dartz/dartz.dart';
import 'package:emeris_app/data/api_calls/wallet_api.dart';
import 'package:emeris_app/data/model/emeris_wallet.dart';
import 'package:emeris_app/domain/entities/balance.dart';
import 'package:emeris_app/domain/entities/failures/general_failure.dart';
import 'package:emeris_app/domain/entities/paginated_list.dart';
import 'package:emeris_app/domain/repositories/balances_repository.dart';

class EmerisBalancesRepository implements BalancesRepository {
  final List<WalletApi> _walletApis;

  EmerisBalancesRepository(this._walletApis);

  @override
  Future<Either<GeneralFailure, PaginatedList<Balance>>> getBalances(EmerisWallet walletData) async =>
      WalletApi.forType(_walletApis, walletData.walletType)
          ?.getWalletBalances(walletData.walletDetails.walletAddress) ??
      Future.value(left(GeneralFailure.unknown("Could not find wallet api for $walletData")));
}
