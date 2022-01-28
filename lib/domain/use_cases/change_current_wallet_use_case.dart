import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/model/failures/change_current_wallet_failure.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';

class ChangeCurrentWalletUseCase {
  ChangeCurrentWalletUseCase(this._walletsStore);

  final WalletsStore _walletsStore;

  Future<Either<ChangeCurrentWalletFailure, Unit>> execute({required EmerisWallet wallet}) async {
    try {
      _walletsStore.currentWallet = wallet;
      return right(unit);
    } catch (ex, stack) {
      logError(ex, stack);
      return left(const ChangeCurrentWalletFailure.unknown());
    }
  }
}
