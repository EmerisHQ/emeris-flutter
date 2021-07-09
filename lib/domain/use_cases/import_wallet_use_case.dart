import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/repositories/wallet_credentials_repository.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/domain/utils/future_either.dart';

class ImportWalletUseCase {
  final WalletCredentialsRepository _walletCredentialsRepository;
  final WalletsStore _walletsStore;

  ImportWalletUseCase(this._walletCredentialsRepository, this._walletsStore);

  Future<Either<AddWalletFailure, Unit>> execute({required ImportWalletFormData walletFormData}) async =>
      _walletCredentialsRepository.importWallet(walletFormData).map((info) {
        _walletsStore.wallets.add(info);
        return right(unit);
      });
}
