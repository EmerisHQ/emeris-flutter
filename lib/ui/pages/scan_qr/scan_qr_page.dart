import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_presentation_model.dart';
import 'package:flutter_app/ui/pages/scan_qr/scan_qr_presenter.dart';
import 'package:flutter_app/ui/pages/scan_qr/widgets/cosmos_qr_view.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);
  final ScanQrPresenter presenter;

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScanQrPresenter>('presenter', presenter));
  }
}

class _ScanQrPageState extends State<ScanQrPage> {
  ScanQrPresenter get presenter => widget.presenter;

  ScanQrViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmosQRView(
        onTapClose: presenter.onTapClose,
        onTapShowQr: presenter.onTapShowQr,
        onQrScanned: presenter.onQrScanned,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ScanQrPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<ScanQrViewModel>('model', model));
  }
}
