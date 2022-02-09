import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/model/failures/send_money_failure.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_initial_params.dart';
import 'package:mobx/mobx.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';

abstract class SendMoneyViewModel {
  Denom get denom;

  WalletType get walletType;

  String get senderAddress;
}

class SendMoneyPresentationModel with SendMoneyPresentationModelBase implements SendMoneyViewModel {
  SendMoneyPresentationModel(
    this.initialParams,
    this._walletsStore,
  );

  final SendMoneyInitialParams initialParams;
  final WalletsStore _walletsStore;

  @override
  Denom get denom => initialParams.denom;

  ObservableFuture<Either<SendMoneyFailure, TransactionHash>>? get sendMoneyFuture => _sendMoneyFuture.value;

  WalletIdentifier get walletIdentifier => _walletsStore.currentWallet.walletDetails.walletIdentifier;

  @override
  WalletType get walletType => initialParams.walletType;

  @override
  String get senderAddress => initialParams.senderAddress;

  String get recipientAddress => _recipientAddress.value;

  String get amountString => _amountString.value;

  bool get isAmountValid => Amount.validate(amountString);

  Amount get amount => Amount.fromString(amountString);
}

mixin SendMoneyPresentationModelBase {
  final Observable<ObservableFuture<Either<SendMoneyFailure, TransactionHash>>?> _sendMoneyFuture = Observable(null);

  set sendMoneyFuture(ObservableFuture<Either<SendMoneyFailure, TransactionHash>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();

  //////////////////////////////////////
  final Observable<String> _recipientAddress = Observable('');

  set recipientAddress(String value) => Action(() => _recipientAddress.value = value)();

  //////////////////////////////////////
  final Observable<String> _amountString = Observable('');

  set amountString(String value) => Action(() => _amountString.value = value)();
}
