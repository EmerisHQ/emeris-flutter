import 'package:flutter_app/ui/pages/scan_qr/scan_qr_initial_params.dart';

abstract class ScanQrViewModel {}

class ScanQrPresentationModel with ScanQrPresentationModelBase implements ScanQrViewModel {
  ScanQrPresentationModel(this.initialParams);

  final ScanQrInitialParams initialParams;
}

abstract class ScanQrPresentationModelBase {}
