// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_initial_params.dart';

abstract class WalletManualBackupViewModel {}

class WalletManualBackupPresentationModel
    with WalletManualBackupPresentationModelBase
    implements WalletManualBackupViewModel {
  final WalletManualBackupInitialParams initialParams;

  WalletManualBackupPresentationModel(this.initialParams);
}

//////////////////BOILERPLATE
abstract class WalletManualBackupPresentationModelBase {}
