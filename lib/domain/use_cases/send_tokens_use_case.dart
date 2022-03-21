import 'package:cosmos_utils/extensions.dart';
import 'package:cosmos_utils/future_either.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/broadcast_transaction.dart';
import 'package:flutter_app/domain/entities/failures/send_tokens_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/entities/send_tokens_form_data.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:flutter_app/domain/use_cases/verify_account_password_use_case.dart';

class SendTokensUseCase {
  SendTokensUseCase(
    this._transactionsRepository,
    this._verifyPasswordUseCase,
  );

  final TransactionsRepository _transactionsRepository;
  final VerifyAccountPasswordUseCase _verifyPasswordUseCase;

  Future<Either<SendTokensFailure, BroadcastTransaction>> execute({
    required AccountIdentifier accountIdentifier,
    required SendTokensFormData sendMoneyData,
    required Passcode passcode,
  }) async =>
      _verifyPasswordUseCase
          .execute(accountIdentifier) //
          .mapError(SendTokensFailure.unknown)
          .flatMap(
            (it) async => _transactionsRepository
                .signAndBroadcast(
                  accountIdentifier: accountIdentifier.byUpdatingPasscode(passcode),
                  transaction: Transaction(
                    accountType: sendMoneyData.accountType,
                    messages: [sendMoneyData],
                    transactionType: TransactionType.sendMoney,
                  ),
                )
                .mapError(SendTokensFailure.unknown),
          );
}
