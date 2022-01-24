import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class SendMoneyInitialParams {
  final WalletType walletType;
  final String walletAddress;
  final Denom denom;

  const SendMoneyInitialParams({
    required this.walletAddress,
    required this.walletType,
    required this.denom,
  });
}