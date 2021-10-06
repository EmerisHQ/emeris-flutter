// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/ui/pages/wallet_backup/wallet_cloud_backup/wallet_cloud_backup_initial_params.dart';

abstract class WalletCloudBackupViewModel {}

class WalletCloudBackupPresentationModel
    with WalletCloudBackupPresentationModelBase
    implements WalletCloudBackupViewModel {
  final WalletCloudBackupInitialParams initialParams;

  WalletCloudBackupPresentationModel(this.initialParams);
}

//////////////////BOILERPLATE
abstract class WalletCloudBackupPresentationModelBase {}