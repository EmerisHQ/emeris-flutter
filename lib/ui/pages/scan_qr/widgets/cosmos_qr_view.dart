import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/extensions/bar_code_result.dart';
import 'package:flutter_app/domain/entities/operating_system.dart';
import 'package:flutter_app/domain/entities/qr_code.dart';
import 'package:flutter_app/domain/stores/platform_info_store.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CosmosQRView extends StatefulWidget {
  const CosmosQRView({
    required this.onQrScanned,
    required this.onTapClose,
    required this.onTapShowQr,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapClose;
  final VoidCallback onTapShowQr;
  final Function(QrCode) onQrScanned;

  @override
  State<StatefulWidget> createState() => _CosmosQRViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapClose', onTapClose))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTapShowQr', onTapShowQr))
      ..add(DiagnosticsProperty<Function>('onQrScanned', onQrScanned));
  }
}

class _CosmosQRViewState extends State<CosmosQRView> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey();

  @override
  void reassemble() {
    super.reassemble();
    final platformInfoStore = PlatformInfoStore();
    if (platformInfoStore.operatingSystem == OperatingSystem.Android) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        _qrView(context),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CosmosBackButton(text: '', onTap: widget.onTapClose),
                  const Spacer(),
                  InkWell(
                    child: Image.asset('assets/images/flash.png'),
                    onTap: () => controller.toggleFlash(),
                  ),
                  SizedBox(width: theme.spacingXL)
                ],
              ),
              Text(
                'Scan QR Code',
                style: CosmosTextTheme.title1Bold.copyWith(color: theme.colors.background),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: theme.spacingXXL),
                          child: Container(
                            padding: EdgeInsets.all(theme.spacingXL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: theme.colors.inactive.withOpacity(0.5),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Scan an address to send assets',
                                  style: CosmosTextTheme.copy0Normal.copyWith(color: theme.colors.background),
                                ),
                                SizedBox(height: theme.spacingL),
                                Text(
                                  'Connect to an app via wallet connect',
                                  style: CosmosTextTheme.copy0Normal.copyWith(color: theme.colors.background),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: theme.spacingXXL),
                  CosmosElevatedButton(
                    onTap: widget.onTapShowQr,
                    text: 'Show my QR code',
                    backgroundColor: theme.colors.background,
                    textColor: theme.colors.text,
                  ),
                  MinimalBottomSpacer(padding: theme.spacingXL)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _qrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        borderColor: Colors.black,
        // overlayColor: Colors.white
        // cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      widget.onQrScanned(scanData.toDomain);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<QRViewController?>('controller', controller))
      ..add(DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>('qrKey', qrKey));
  }
}
