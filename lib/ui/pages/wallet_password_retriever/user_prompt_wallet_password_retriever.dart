import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/use_cases/verify_wallet_password_use_case.dart';
import 'package:flutter_app/domain/utils/wallet_password_retriever.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/utils/strings.dart';

class UserPromptWalletPasswordRetriever implements WalletPasswordRetriever {
  final Map<String, String> _passwords = {};
  final VerifyWalletPasswordUseCase _verifyWalletPasswordUseCase;

  UserPromptWalletPasswordRetriever(this._verifyWalletPasswordUseCase);

  @override
  Future<Either<GeneralFailure, String>> getWalletPassword(WalletIdentifier walletIdentifier) async {
    var password = walletIdentifier.password ?? _passwords[walletIdentifier.walletId];
    if (password != null) {
      return _storeAndReturn(walletIdentifier, password);
    } else {
      password = await showDialog(
        context: AppNavigator.navigatorKey.currentContext!,
        builder: (context) => const PasswordUserPromptDialog(),
      ) as String?;
      if ((await _verifyWalletPasswordUseCase.execute(walletIdentifier.byUpdatingPassword(password))).isRight()) {
        _passwords[walletIdentifier.walletId] = password!;
        return _storeAndReturn(walletIdentifier, password);
      } else {
        return left(const GeneralFailure.unknown("User did not provide the password"));
      }
    }
  }

  Either<GeneralFailure, String> _storeAndReturn(WalletIdentifier walletIdentifier, String password) {
    _passwords[walletIdentifier.walletId] = password;
    return right(password);
  }
}

class PasswordUserPromptDialog extends StatefulWidget {
  const PasswordUserPromptDialog({Key? key}) : super(key: key);

  @override
  _PasswordUserPromptDialogState createState() => _PasswordUserPromptDialogState();
}

class _PasswordUserPromptDialogState extends State<PasswordUserPromptDialog> {
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: _passwordController,
        decoration: InputDecoration(hintText: strings.enterPassword),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(_passwordController.text),
          child: Text(strings.okAction),
        ),
      ],
    );
  }
}
