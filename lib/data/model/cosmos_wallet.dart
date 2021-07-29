import 'package:alan/alan.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';

class CosmosWallet extends EmerisWallet {
  final Wallet wallet;

  @override
  const CosmosWallet({
    required WalletDetails walletDetails,
    required this.wallet,
  }) : super(
          walletDetails: walletDetails,
          walletType: WalletType.Cosmos,
        );
}
