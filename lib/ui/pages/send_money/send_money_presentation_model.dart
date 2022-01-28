import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/domain/stores/wallets_store.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_initial_params.dart';
import 'package:mobx/mobx.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';

abstract class SendMoneyViewModel {
  Denom get denom;
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

  ObservableFuture<Either<GeneralFailure, TransactionHash>>? get sendMoneyFuture => _sendMoneyFuture.value;

  WalletIdentifier? get walletIdentifier => _walletsStore.currentWallet?.walletDetails.walletIdentifier;
}

mixin SendMoneyPresentationModelBase {
  final Observable<ObservableFuture<Either<GeneralFailure, TransactionHash>>?> _sendMoneyFuture = Observable(null);

  set sendMoneyFuture(ObservableFuture<Either<GeneralFailure, TransactionHash>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();
}
