import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/backup_later_confirmation_sheet.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_backup_intro/wallet_backup_intro_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_initial_params.dart';

class WalletBackupIntroPresenter {
  WalletBackupIntroPresenter(
    this._model,
    this.navigator,
  );

  final WalletBackupIntroPresentationModel _model;
  final WalletBackupIntroNavigator navigator;

  WalletBackupIntroViewModel get viewModel => _model;

  void onTapCloudBackup() => navigator.openWalletCloudBackup(const WalletCloudBackupInitialParams());

  Future<void> onTapManualBackup() async {
    final result = await navigator.openWalletManualBackup(
      WalletManualBackupInitialParams(
        mnemonic: _model.mnemonic,
      ),
    );
    if (result ?? true) {
      await navigator.openRouting(const RoutingInitialParams());
    }
  }

  Future<void> onTapBackupLater() async {
    final decision = await navigator.openBackupLaterConfirmation();
    if (decision == BackupLaterConfirmationResult.skipBackup) {
      await navigator.openRouting(const RoutingInitialParams());
    }
  }
}
