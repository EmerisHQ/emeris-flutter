import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:web3dart/web3dart.dart';

class EthereumWallet extends EmerisWallet {
  final Wallet wallet;

  @override
  const EthereumWallet({
    required WalletDetails walletDetails,
    required this.wallet,
  }) : super(
          walletDetails: walletDetails,
          walletType: WalletType.Eth,
        );
}
