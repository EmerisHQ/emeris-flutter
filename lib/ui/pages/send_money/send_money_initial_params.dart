import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class SendMoneyInitialParams {
  const SendMoneyInitialParams({
    required this.senderAddress,
    required this.walletType,
    required this.denom,
  });

  final WalletType walletType;
  final String senderAddress;
  final Denom denom;
}
