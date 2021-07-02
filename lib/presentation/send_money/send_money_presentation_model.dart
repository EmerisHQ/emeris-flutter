import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/model/failures/add_wallet_failure.dart';
import 'package:flutter_app/presentation/send_money/send_money_initial_params.dart';
import 'package:mobx/mobx.dart';

abstract class SendMoneyViewModel {}

class SendMoneyPresentationModel with SendMoneyPresentationModelBase implements SendMoneyViewModel {
  final SendMoneyInitialParams initialParams;

  SendMoneyPresentationModel(
    this.initialParams,
  );

  ObservableFuture<Either<AddWalletFailure, Unit>>? get sendMoneyFuture => _sendMoneyFuture.value;
}

abstract class SendMoneyPresentationModelBase {
  final Observable<ObservableFuture<Either<AddWalletFailure, Unit>>?> _sendMoneyFuture = Observable(null);

  set sendMoneyFuture(ObservableFuture<Either<AddWalletFailure, Unit>>? value) =>
      Action(() => _sendMoneyFuture.value = value)();
}
