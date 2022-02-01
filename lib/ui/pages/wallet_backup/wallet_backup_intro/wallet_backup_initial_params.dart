import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';

class WalletBackupIntroInitialParams {
  const WalletBackupIntroInitialParams({required this.wallet, required this.mnemonic});

  final EmerisWallet wallet;
  final Mnemonic mnemonic;
}
