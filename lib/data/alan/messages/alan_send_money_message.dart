import 'package:alan/proto/cosmos/bank/v1beta1/export.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:alan/proto/cosmos/base/v1beta1/export.dart';
import 'package:flutter_app/domain/entities/send_money_message.dart';

extension AlanMsgSend on MsgSend {
  static MsgSend fromDomain(SendMoneyMessage moneyMessage) {
    final msgSend = bank.MsgSend.create()
      ..fromAddress = moneyMessage.fromAddress
      ..toAddress = moneyMessage.toAddress;
    msgSend.amount.add(
      Coin.create()
        ..denom = moneyMessage.balance.denom.text
        ..amount = moneyMessage.balance.amount.displayText,
    );
    return msgSend;
  }
}
