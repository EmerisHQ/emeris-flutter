import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';

class WalletBackupIntroInitialParams {
  final EmerisWallet wallet;
  final Mnemonic mnemonic;

  const WalletBackupIntroInitialParams({required this.wallet, required this.mnemonic});
}
