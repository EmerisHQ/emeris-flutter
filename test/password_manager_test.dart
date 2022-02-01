import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/utils/password_manager.dart';
import 'package:flutter_app/ui/pages/wallet_password_retriever/biometric_wallet_password_retriever.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/biometric_storage_mock.dart';
import 'mocks/user_prompt_wallet_password_retiever_mock.dart';

void main() {
  const chainId = 'atom';
  const walletId = '123walletId';
  const walletIdentifier = WalletIdentifier(walletId: walletId, chainId: chainId);
  late BiometricStorageMock biometricStorageMock;
  late BiometricStorageFileMock biometricStorageFileMock;

  test("Biometric was not available and user didn't provide any password returns failure", () async {
    when(() => biometricStorageMock.canAuthenticate()).thenAnswer((_) async => CanAuthenticateResponse.statusUnknown);

    when(() => biometricStorageMock.getStorage(any())).thenAnswer((_) async => biometricStorageFileMock);

    when(() => biometricStorageFileMock.read()).thenAnswer((_) async => null);

    final manager = PasswordManager(
      BiometricWalletPasswordRetriever(biometricStorageMock),
      UserPromptWalletPasswordRetrieverMock(),
    );

    final password = await manager.retrievePassword(walletIdentifier);

    expect(password.isLeft(), true);

    verify(() => biometricStorageMock.canAuthenticate());
    verifyNever(() => biometricStorageMock.getStorage(any()));
    verifyNever(() => biometricStorageFileMock.read());
  });

  test(
      "Biometric was available but biometric didn't have any saved passwords and user didn't provide any password returns failure",
      () async {
    when(() => biometricStorageMock.canAuthenticate()).thenAnswer((_) async => CanAuthenticateResponse.success);

    when(() => biometricStorageMock.getStorage(any())).thenAnswer((_) async => biometricStorageFileMock);

    when(() => biometricStorageFileMock.read()).thenAnswer((_) async => null);

    final manager = PasswordManager(
      BiometricWalletPasswordRetriever(biometricStorageMock),
      UserPromptWalletPasswordRetrieverMock(),
    );

    final password = await manager.retrievePassword(walletIdentifier);

    expect(password.isLeft(), true);

    verify(() => biometricStorageMock.canAuthenticate());
    verify(() => biometricStorageMock.getStorage(any()));
    verify(() => biometricStorageFileMock.read());
  });

  test('Biometric was available and biometric had saved password returns success', () async {
    when(() => biometricStorageMock.canAuthenticate()).thenAnswer((_) async => CanAuthenticateResponse.success);

    when(() => biometricStorageMock.getStorage(any())).thenAnswer((_) async => biometricStorageFileMock);

    when(() => biometricStorageFileMock.read()).thenAnswer((_) async => 'Sample');

    final manager = PasswordManager(
      BiometricWalletPasswordRetriever(biometricStorageMock),
      UserPromptWalletPasswordRetrieverMock(),
    );

    final password = await manager.retrievePassword(walletIdentifier);

    expect(password.isRight(), true);

    verify(() => biometricStorageMock.canAuthenticate());
    verify(() => biometricStorageMock.getStorage(any()));
    verify(() => biometricStorageFileMock.read());
  });

  test('Biometric was not available and user entered a password returns success', () async {
    when(() => biometricStorageMock.canAuthenticate()).thenAnswer((_) async => CanAuthenticateResponse.statusUnknown);

    when(() => biometricStorageMock.getStorage(any())).thenAnswer((_) async => biometricStorageFileMock);

    when(() => biometricStorageFileMock.read()).thenAnswer((_) async => 'Sample');

    final manager = PasswordManager(
      BiometricWalletPasswordRetriever(biometricStorageMock),
      UserPromptWalletPasswordRetrieverMock(isPasswordEntered: true),
    );

    final password = await manager.retrievePassword(walletIdentifier);

    expect(password.isRight(), true);

    verify(() => biometricStorageMock.canAuthenticate());
    verifyNever(() => biometricStorageMock.getStorage(any()));
    verifyNever(() => biometricStorageFileMock.read());
  });

  setUp(() {
    biometricStorageMock = BiometricStorageMock();
    biometricStorageFileMock = BiometricStorageFileMock();
  });
}
