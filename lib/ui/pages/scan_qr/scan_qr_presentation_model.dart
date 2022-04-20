import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_initial_params.dart';

abstract class ScanQrViewModel {}

class ScanQrPresentationModel with ScanQrPresentationModelBase implements ScanQrViewModel {
  ScanQrPresentationModel(this.initialParams, this._accountsStore);

  final ScanQrInitialParams initialParams;

  final AccountsStore _accountsStore;

  EmerisAccount get account => _accountsStore.currentAccount;
}

abstract class ScanQrPresentationModelBase {}
