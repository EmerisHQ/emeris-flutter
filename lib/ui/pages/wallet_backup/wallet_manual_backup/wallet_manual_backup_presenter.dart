import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';

class WalletManualBackupPresenter {
  WalletManualBackupPresenter(
    this._model,
    this.navigator,
  );

  final WalletManualBackupPresentationModel _model;
  final WalletManualBackupNavigator navigator;

  WalletManualBackupViewModel get viewModel => _model;
}
