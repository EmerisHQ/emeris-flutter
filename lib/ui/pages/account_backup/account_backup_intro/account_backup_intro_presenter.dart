import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/account_backup_intro_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_backup_intro/backup_later_confirmation_sheet.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_initial_params.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_initial_params.dart';

class AccountBackupIntroPresenter {
  AccountBackupIntroPresenter(
    this._model,
    this.navigator,
  );

  final AccountBackupIntroPresentationModel _model;
  final AccountBackupIntroNavigator navigator;

  AccountBackupIntroViewModel get viewModel => _model;

  void onTapCloudBackup() => navigator.openAccountCloudBackup(const AccountCloudBackupInitialParams());

  Future<void> onTapManualBackup() async {
    final result = await navigator.openAccountManualBackup(
      AccountManualBackupInitialParams(
        mnemonic: _model.mnemonic,
      ),
    );
    if (result != null) {
      navigator.closeWithResult(result);
    }
  }

  Future<void> onTapBackupLater() async {
    final decision = await navigator.openBackupLaterConfirmation();
    if (decision == BackupLaterConfirmationResult.skipBackup) {
      navigator.closeWithResult(true);
    }
  }
}
