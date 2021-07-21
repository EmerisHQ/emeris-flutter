import 'package:dartz/dartz.dart';
import 'package:emeris_app/domain/entities/wallet_identifier.dart';
import 'package:emeris_app/domain/model/failures/verify_wallet_password_failure.dart';
import 'package:emeris_app/domain/repositories/wallets_repository.dart';

class VerifyWalletPasswordUseCase {
  final WalletsRepository _walletsRepository;

  VerifyWalletPasswordUseCase(this._walletsRepository);

  Future<Either<VerifyWalletPasswordFailure, bool>> execute(WalletIdentifier walletIdentifier) async {
    if (walletIdentifier.password == null) {
      return left(const VerifyWalletPasswordFailure.invalidPassword());
    }
    return _walletsRepository.verifyPassword(walletIdentifier);
  }
}
