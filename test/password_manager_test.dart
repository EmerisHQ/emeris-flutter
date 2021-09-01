import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/utils/password_manager.dart';
import 'package:flutter_app/ui/pages/wallet_password_retriever/biometric_wallet_password_retriever.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/biometric_storage_mock.dart';
import 'mocks/user_prompt_wallet_password_retiever_mock.dart';

void main() {
  const chainId = "atom";
  const walletId = "123walletId";
  const walletIdentifier = WalletIdentifier(walletId: walletId, chainId: chainId);

  test("Biometric not available and user didn't provide any password returns failure", () async {
    final manager = PasswordManager(
      BiometricWalletPasswordRetriever(BiometricStorageMock()),
      UserPromptWalletPasswordRetrieverMock(),
    );

    final password = await manager
        .retrievePassword(walletIdentifier)
        .onError((error, stackTrace) => left(GeneralFailure.unknown(error.toString(), stackTrace)));

    expect(password.isLeft(), true);
  });

  test(
      "Biometric was available but biometric didn't have any saved passwords and user didn't provide any password returns failure",
      () async {
    final manager = PasswordManager(
      BiometricWalletPasswordRetriever(BiometricStorageMock(isAuth: true)),
      UserPromptWalletPasswordRetrieverMock(),
    );

    final password = await manager
        .retrievePassword(walletIdentifier)
        .onError((error, stackTrace) => left(GeneralFailure.unknown(error.toString(), stackTrace)));

    expect(password.isLeft(), true);
  });

  test("Biometric not available and user provides a password returns success", () async {
    final manager = PasswordManager(
      BiometricWalletPasswordRetriever(BiometricStorageMock()),
      UserPromptWalletPasswordRetrieverMock(isPasswordEntered: true),
    );

    final password = await manager
        .retrievePassword(walletIdentifier)
        .onError((error, stackTrace) => left(GeneralFailure.unknown(error.toString(), stackTrace)));

    expect(password.isRight(), true);
  });
}
