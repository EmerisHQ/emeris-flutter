import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_wallets_list_failure.dart';
import 'package:flutter_app/domain/entities/failures/verify_wallet_password_failure.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';

abstract class WalletsRepository {
  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(ImportWalletFormData walletFormData);

  Future<Either<GetWalletsListFailure, List<EmerisWallet>>> getWalletsList();

  Future<Either<VerifyWalletPasswordFailure, bool>> verifyPassword(WalletIdentifier walletIdentifier);
}
