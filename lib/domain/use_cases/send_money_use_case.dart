import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/entities/send_money_data.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/utils/logger.dart';

class SendMoneyUseCase {
  Future<Either<AddWalletFailure, Unit>> execute({required SendMoneyData sendMoneyData}) async {
    //TODO create fully-fledged wallet manager/repository for this
    try {
      final api = sendMoneyData.walletType == WalletType.Cosmos ? cosmosApi : ethApi;
      await api.sendAmount(
        balance: sendMoneyData.balance,
        fromAddress: sendMoneyData.fromAddress,
        toAddress: sendMoneyData.toAddress,
      );
      return right(unit);
    } catch (e) {
      logError(e);
      return left(const AddWalletFailure.unknown());
    }
  }
}
