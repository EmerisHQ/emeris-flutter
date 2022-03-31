import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/chain.dart';
import 'package:flutter_app/domain/entities/transaction_fee.dart';
import 'package:flutter_app/domain/entities/transaction_message.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';

class SendTokensFormData extends Equatable implements TransactionMessage {
  const SendTokensFormData({
    required this.sendAmount,
    required this.fee,
    required this.recipient,
    required this.recipientChain,
    required this.sender,
    required this.senderChain,
    required this.verifiedDenom,
  });

  final Amount sendAmount;
  final TransactionFee fee;
  final AccountAddress recipient;
  final Chain recipientChain;
  final AccountAddress sender;
  final Chain senderChain;
  final VerifiedDenom verifiedDenom;

  Amount get receiveAmount => sendAmount - fee.amount;

  AccountType get accountType => AccountType.Cosmos; // for now we'll support only cosmos type transactions

  @override
  List<Object> get props => [
        sendAmount,
        fee,
        recipient,
        recipientChain,
        sender,
        senderChain,
        verifiedDenom,
      ];

  String get feeWithDenomText => verifiedDenom.amountWithDenomText(fee.amount);
}
