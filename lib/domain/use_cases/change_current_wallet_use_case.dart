import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/change_current_wallet_failure.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';

class ChangeCurrentWalletUseCase {
  ChangeCurrentWalletUseCase(this._walletsStore);

  final WalletsStore _walletsStore;

  Future<Either<ChangeCurrentWalletFailure, Unit>> execute({required EmerisWallet wallet}) async {
    _walletsStore.currentWallet = wallet;
    return right(unit);
  }
}
