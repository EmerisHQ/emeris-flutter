import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/send_money_message.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:flutter_app/domain/entities/transaction_hash.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/repositories/transactions_repository.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:flutter_app/domain/utils/wallet_password_retriever.dart';

class SendMoneyUseCase {
  final TransactionsRepository _transactionsRepository;
  final WalletPasswordRetriever _walletPasswordRetriever;

  SendMoneyUseCase(this._transactionsRepository, this._walletPasswordRetriever);

  Future<Either<GeneralFailure, TransactionHash>> execute({
    required WalletIdentifier walletIdentifier,
    required SendMoneyMessage sendMoneyData,
  }) async =>
      _walletPasswordRetriever
          .getWalletPassword(walletIdentifier) //
          .flatMap(
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
