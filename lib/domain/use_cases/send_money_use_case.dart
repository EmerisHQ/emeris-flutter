import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/send_money_message.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:flutter_app/domain/utils/password_manager.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';

class SendMoneyUseCase {
  final TransactionsRepository _transactionsRepository;
  final PasswordManager _passwordManager;

  SendMoneyUseCase(
    this._transactionsRepository,
    this._passwordManager,
  );

  Future<Either<GeneralFailure, TransactionHash>> execute({
    required WalletIdentifier walletIdentifier,
    required SendMoneyMessage sendMoneyData,
  }) async =>
      _passwordManager.retrievePassword(walletIdentifier).flatMap(
            (password) => _transactionsRepository.signAndBroadcast(
              walletIdentifier: walletIdentifier.byUpdatingPassword(password),
              transaction: Transaction(
                walletType: sendMoneyData.walletType,
                messages: [sendMoneyData],
                transactionType: TransactionType.sendMoney,
              ),
            ),
          );
}
