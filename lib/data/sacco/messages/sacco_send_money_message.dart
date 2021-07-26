import 'package:flutter_app/domain/entities/send_money_message.dart';
import 'package:sacco/models/export.dart';

class SaccoSendMoneyMessage {
  late String fromAddress;
  late String toAddress;
  late List<SaccoAmount> amount;

  SaccoSendMoneyMessage({required this.fromAddress, required this.toAddress, required this.amount});

  SaccoSendMoneyMessage.fromJson(Map<String, dynamic> json) {
    fromAddress = json['from_address'] as String;
    toAddress = json['to_address'] as String;
    amount = <SaccoAmount>[];
    if (json['amount'] != null) {
      amount = <SaccoAmount>[];
      json['amount'].forEach((Map<String, dynamic> v) {
        amount.add(SaccoAmount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['from_address'] = fromAddress;
    data['to_address'] = toAddress;
    data['amount'] = amount.map((v) => v.toJson()).toList();
    return data;
  }

  SaccoSendMoneyMessage.fromDomain(SendMoneyMessage moneyMessage)
      : fromAddress = moneyMessage.fromAddress,
        toAddress = moneyMessage.toAddress,
        amount = [
          SaccoAmount(
            denom: moneyMessage.balance.denom.text,
            amount: moneyMessage.balance.amount.displayText,
          ),
        ];

  StdMsg toStdMsg() => StdMsg(
        type: 'cosmos-sdk/MsgSend',
        value: toJson(),
      );
}

class SaccoAmount {
  late String denom;
  late String amount;

  SaccoAmount({required this.denom, required this.amount});

  SaccoAmount.fromJson(Map<String, dynamic> json) {
    denom = json['denom'] as String;
    amount = json['amount'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['denom'] = denom;
    data['amount'] = amount;
    return data;
  }
}
