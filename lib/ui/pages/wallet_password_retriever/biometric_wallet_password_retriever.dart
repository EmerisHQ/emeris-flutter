import 'package:biometric_storage/biometric_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/utils/wallet_password_retriever.dart';

class BiometricWalletPasswordRetriever implements WalletPasswordRetriever {
  BiometricStorage storage;
  PromptInfo promptInfo;
  final _passwordKey = '_password';

  BiometricWalletPasswordRetriever(this.storage, {this.promptInfo = PromptInfo.defaultValues});

  @override
  Future<Either<GeneralFailure, String>> getWalletPassword(WalletIdentifier walletIdentifier) async {
    try {
      final store = await storage.getStorage(walletIdentifier.walletId + _passwordKey, promptInfo: promptInfo);
      final data = await store.read();
      return right(data!);
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('Could not get password', ex, stack));
    }
  }

  Future<Either<GeneralFailure, bool>> canAuthenticate(WalletIdentifier walletIdentifier) async {
    try {
      final response = await storage.canAuthenticate();
      if (response == CanAuthenticateResponse.success) {
        return right(true);
      } else {
        return right(false);
      }
    } catch (ex, stack) {
      return left(GeneralFailure.unknown(ex.toString(), stack));
    }
  }

  Future<Either<GeneralFailure, void>> storePassword(WalletIdentifier walletIdentifier) async {
    try {
      final store = await storage.getStorage(walletIdentifier.walletId + _passwordKey, promptInfo: promptInfo);
      await store.write(walletIdentifier.password!);
      return right(null);
    } catch (ex, stack) {
      return left(GeneralFailure.unknown('Could not store password', ex, stack));
    }
  }

  Future<Either<GeneralFailure, bool>> hasPassword(WalletIdentifier walletIdentifier) async {
    final store = await storage.getStorage(walletIdentifier.walletId + _passwordKey, promptInfo: promptInfo);
    final data = await store.read();
    if (data == null) {
      return left(GeneralFailure.unknown('Password not found'));
    } else {
      return right(true);
    }
  }
}
