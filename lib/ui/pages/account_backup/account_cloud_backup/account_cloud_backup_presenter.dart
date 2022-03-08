import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_navigator.dart';
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_presentation_model.dart';

class AccountCloudBackupPresenter {
  AccountCloudBackupPresenter(
    this._model,
    this.navigator,
  );

  final AccountCloudBackupPresentationModel _model;
  final AccountCloudBackupNavigator navigator;

  AccountCloudBackupViewModel get viewModel => _model;
}
