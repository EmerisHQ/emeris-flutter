// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/account_backup/account_cloud_backup/account_cloud_backup_initial_params.dart';

abstract class AccountCloudBackupViewModel {}

class AccountCloudBackupPresentationModel
    with AccountCloudBackupPresentationModelBase
    implements AccountCloudBackupViewModel {
  AccountCloudBackupPresentationModel(this.initialParams);

  final AccountCloudBackupInitialParams initialParams;
}

//////////////////BOILERPLATE
mixin AccountCloudBackupPresentationModelBase {}
