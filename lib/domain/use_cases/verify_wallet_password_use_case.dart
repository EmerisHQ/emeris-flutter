import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/verify_wallet_password_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/repositories/wallets_repository.dart';

class VerifyWalletPasswordUseCase {
  VerifyWalletPasswordUseCase(this._walletsRepository);

  final WalletsRepository _walletsRepository;

  /// checks if the [walletIdentifier] contains a valid password for this given wallet
  Future<Either<VerifyWalletPasswordFailure, bool>> execute(WalletIdentifier walletIdentifier) async {
    if (walletIdentifier.password == null) {
      return left(const VerifyWalletPasswordFailure.invalidPassword());
    }
    return _walletsRepository.verifyPassword(walletIdentifier);
  }
}
