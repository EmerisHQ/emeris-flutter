import 'package:cosmos_utils/extensions.dart';
import 'package:cosmos_utils/future_either.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/send_tokens_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/entities/send_tokens_form_data.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:flutter_app/domain/use_cases/verify_wallet_password_use_case.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';

class SendTokensUseCase {
  SendTokensUseCase(
    this._transactionsRepository,
    this._verifyPasswordUseCase,
  );

  final TransactionsRepository _transactionsRepository;
  final VerifyWalletPasswordUseCase _verifyPasswordUseCase;

  Future<Either<SendTokensFailure, TransactionHash>> execute({
    required WalletIdentifier walletIdentifier,
    required SendTokensFormData sendMoneyData,
    required Passcode passcode,
  }) async =>
      _verifyPasswordUseCase
          .execute(walletIdentifier) //
          .mapError(SendTokensFailure.unknown)
          .flatMap(
            (it) async => _transactionsRepository
                .signAndBroadcast(
                  walletIdentifier: walletIdentifier.byUpdatingPasscode(passcode),
                  transaction: Transaction(
                    walletType: sendMoneyData.walletType,
                    messages: [sendMoneyData],
                    transactionType: TransactionType.sendMoney,
                  ),
                )
                .mapError(SendTokensFailure.unknown),
          );
}