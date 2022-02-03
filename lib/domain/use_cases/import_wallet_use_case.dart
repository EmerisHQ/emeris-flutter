import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/use_cases/change_current_wallet_use_case.dart';
import 'package:flutter_app/domain/utils/future_either.dart';

class ImportWalletUseCase {
  ImportWalletUseCase(
    this._walletCredentialsRepository,
    this._walletsStore,
    this._changeCurrentWalletUseCase,
  );

  final WalletsRepository _walletCredentialsRepository;
  final WalletsStore _walletsStore;
  final ChangeCurrentWalletUseCase _changeCurrentWalletUseCase;

  Future<Either<AddWalletFailure, EmerisWallet>> execute({required ImportWalletFormData walletFormData}) async =>
      _walletCredentialsRepository.importWallet(walletFormData).flatMap((wallet) {
        _walletsStore.addWallet(wallet);
        return _changeCurrentWalletUseCase
            .execute(wallet: wallet)
            .mapError((it) => AddWalletFailure.unknown(cause: it))
            .mapSuccess((_) => wallet);
      });
}
