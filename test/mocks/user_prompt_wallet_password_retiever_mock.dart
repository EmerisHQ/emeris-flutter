import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/ui/pages/wallet_password_retriever/user_prompt_wallet_password_retriever.dart';

class UserPromptWalletPasswordRetrieverMock implements UserPromptWalletPasswordRetriever {
  UserPromptWalletPasswordRetrieverMock({this.isPasswordEntered = false});

  final bool isPasswordEntered;

  @override
  Future<Either<GeneralFailure, String>> getWalletPassword(WalletIdentifier walletIdentifier) async {
    if (isPasswordEntered) {
      return right('Sample');
    } else {
      return left(GeneralFailure.unknown('User did not provide the password', 'Password not provided'));
    }
  }
}
