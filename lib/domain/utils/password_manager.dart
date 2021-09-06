import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/ui/pages/wallet_password_retriever/biometric_wallet_password_retriever.dart';
import 'package:flutter_app/ui/pages/wallet_password_retriever/user_prompt_wallet_password_retriever.dart';

class PasswordManager {
  final BiometricWalletPasswordRetriever _biometricRetriever;
  final UserPromptWalletPasswordRetriever _userPromptRetriever;

  PasswordManager(this._biometricRetriever, this._userPromptRetriever);

  Future<Either<GeneralFailure, String>> retrievePassword(WalletIdentifier walletIdentifier) async {
    try {
      final canAuth = (await _biometricRetriever.canAuthenticate(walletIdentifier)).fold(
        (fail) => throw fail,
        (can) => can,
      );
      if (canAuth) {
        final hasBiometricPassword = (await _biometricRetriever.hasPassword(walletIdentifier)).fold(
          (fail) => throw fail,
          (has) => has,
        );
        if (hasBiometricPassword) {
          return _biometricRetriever.getWalletPassword(walletIdentifier);
        }
      }
      return _userPromptRetriever.getWalletPassword(walletIdentifier);
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('cannot retrieve password', ex, stack));
    }
  }
}
