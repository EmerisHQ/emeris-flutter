import 'package:biometric_storage/biometric_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/utils/wallet_password_retriever.dart';

class BiometricPasswordRetriever implements WalletPasswordRetriever {
  BiometricStorage storage = BiometricStorage();
  PromptInfo promptInfo;
  final _passwordKey = '_password';

  BiometricPasswordRetriever({this.promptInfo = PromptInfo.defaultValues});

  @override
  Future<Either<GeneralFailure, String>> getWalletPassword(WalletIdentifier walletIdentifier) async {
    try {
      final store = await storage.getStorage(walletIdentifier.walletId + _passwordKey, promptInfo: promptInfo);
      final data = await store.read();
      return right(data!);
    } catch (ex) {
      return left(const GeneralFailure.unknown('Could not get password'));
    }
  }

  Future<Either<GeneralFailure, bool>> canAuthenticate(WalletIdentifier walletIdentifier) async {
    final response = await storage.canAuthenticate();
    if (response == CanAuthenticateResponse.success) {
      return right(true);
    } else {
      return left(const GeneralFailure.unknown('Biometric not available'));
    }
  }

  Future<Either<GeneralFailure, void>> storePassword(WalletIdentifier walletIdentifier) async {
    try {
      final store = await storage.getStorage(walletIdentifier.walletId + _passwordKey, promptInfo: promptInfo);
      await store.write(walletIdentifier.password!);
      return right(null);
    } catch (ex) {
      return left(const GeneralFailure.unknown('Could not store password'));
    }
  }

  Future<Either<GeneralFailure, bool>> hasPassword(WalletIdentifier walletIdentifier) async {
    final store = await storage.getStorage(walletIdentifier.walletId + _passwordKey, promptInfo: promptInfo);
    final data = await store.read();
    if (data == null) {
      return left(const GeneralFailure.unknown('Password not found'));
    } else {
      return right(true);
    }
  }
}
