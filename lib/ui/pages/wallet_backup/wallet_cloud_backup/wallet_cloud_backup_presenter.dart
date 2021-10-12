import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_presentation_model.dart';

class WalletCloudBackupPresenter {
  WalletCloudBackupPresenter(
    this._model,
    this.navigator,
  );

  final WalletCloudBackupPresentationModel _model;
  final WalletCloudBackupNavigator navigator;

  WalletCloudBackupViewModel get viewModel => _model;
}
