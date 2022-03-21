import 'package:alan/proto/cosmos/bank/v1beta1/export.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:alan/proto/cosmos/base/v1beta1/export.dart';
import 'package:flutter_app/domain/entities/send_tokens_form_data.dart';

extension AlanMsgSend on MsgSend {
  static MsgSend fromDomain(SendTokensFormData formData) {
    final msgSend = bank.MsgSend.create()
      ..fromAddress = formData.sender.value
      ..toAddress = formData.recipient.value;
    msgSend.amount.add(
      Coin.create()
        ..denom = formData.verifiedDenom.denom.id
        ..amount = formData.sendAmount.toString(),
    );
    return msgSend;
  }
}
