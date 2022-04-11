import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/scan_qr/widgets/cosmos_qr_view.dart';

class ScanQrPage extends StatelessWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmosQRView(
        onTapClose: () {},
        onTapShowQr: () {},
        onQrScanned: (value) {},
      ),
    );
  }
}
