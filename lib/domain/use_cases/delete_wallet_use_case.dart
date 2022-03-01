import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/delete_wallet_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/change_current_wallet_use_case.dart';
import 'package:flutter_app/domain/utils/future_either.dart';

class DeleteWalletUseCase {
  DeleteWalletUseCase(this._walletsRepository, this._walletsStore, this._changeCurrentWalletUseCase);

  final WalletsRepository _walletsRepository;
  final WalletsStore _walletsStore;
  final ChangeCurrentWalletUseCase _changeCurrentWalletUseCase;

  Future<Either<DeleteWalletFailure, bool>> execute({
    required EmerisWallet wallet,
    required Passcode passcode,
  }) =>
      _walletsRepository.deleteWallet(wallet.walletDetails.walletIdentifier.byUpdatingPasscode(passcode)).map(
        (_) {
          _walletsStore.removeWallet(wallet);
          if (_walletsStore.currentWallet == wallet) {
            _changeCurrentWalletUseCase.execute(
              wallet: _walletsStore.wallets.isEmpty ? const EmerisWallet.empty() : _walletsStore.wallets.first,
            );
          }
          return right(_walletsStore.wallets.isEmpty);
        },
      );
}
