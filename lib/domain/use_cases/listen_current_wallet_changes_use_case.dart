import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';

class ListenCurrentWalletChangesUseCase {
  const ListenCurrentWalletChangesUseCase(this._walletsStore);

  final WalletsStore _walletsStore;

  Future<Either<GeneralFailure, Unit>> execute({required Function(EmerisWallet) onChanged}) async {
    return right(unit);
  }
}
