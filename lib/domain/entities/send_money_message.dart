import 'package:equatable/equatable.dart';
import 'package:emeris_app/data/model/wallet_type.dart';
import 'package:emeris_app/domain/entities/balance.dart';
import 'package:emeris_app/domain/entities/transaction_message.dart';

class SendMoneyMessage extends Equatable implements TransactionMessage {
  final WalletType walletType;
  final Balance balance;
  final String toAddress;
  final String fromAddress;

  const SendMoneyMessage({
    required this.balance,
    required this.walletType,
    required this.fromAddress,
    required this.toAddress,
  });

  @override
  List<Object> get props => [
        balance,
        walletType,
        fromAddress,
        toAddress,
      ];
}
