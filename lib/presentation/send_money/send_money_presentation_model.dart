import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/transaction_hash.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/presentation/send_money/send_money_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class SendMoneyViewModel {
  Denom get denom;
}

class SendMoneyPresentationModel with SendMoneyPresentationModelBase implements SendMoneyViewModel {
  final SendMoneyInitialParams initialParams;
  final WalletsStore _walletsStore;

  @override
  Denom get denom => initialParams.denom;

  SendMoneyPresentationModel(
    this.initialParams,
    this._walletsStore,
  );

  ObservableFuture<Either<GeneralFailure, TransactionHash>>? get sendMoneyFuture => _sendMoneyFuture.value;

  WalletIdentifier? get walletIdentifier => _walletsStore.currentWallet?.walletDetails.walletIdentifier;
}

abstract class SendMoneyPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, TransactionHash>>?> _sendMoneyFuture = Observable(null);

  set sendMoneyFuture(ObservableFuture<Either<GeneralFailure, TransactionHash>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();
}
