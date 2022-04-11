import 'package:flutter_app/domain/entities/qr_code.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_navigator.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_presentation_model.dart';

class ScanQrPresenter {
  ScanQrPresenter(
    this._model,
    this.navigator,
  );

  final ScanQrNavigator navigator;

  final ScanQrPresentationModel _model;

  ScanQrViewModel get viewModel => _model;

  void onTapClose() => navigator.close();

  void onTapShowQr() => showNotImplemented();

  void onQrScanned(QrCode qrCode) {
    // TODO: Next steps after QR scanned
  }
}
