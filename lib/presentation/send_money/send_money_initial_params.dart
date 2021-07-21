import 'package:emeris_app/data/model/wallet_type.dart';
import 'package:emeris_app/domain/entities/denom.dart';

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
