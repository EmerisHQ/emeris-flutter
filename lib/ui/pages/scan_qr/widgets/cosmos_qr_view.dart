import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/extensions/bar_code_result.dart';
import 'package:flutter_app/domain/entities/qr_code.dart';
import 'package:flutter_app/generated_assets/assets.gen.dart';
import 'package:flutter_app/utils/strings.dart';
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
  final void Function(QrCode) onQrScanned;

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
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey();

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
              _headerButtons(theme),
              SizedBox(height: theme.spacingXXXL),
              Text(
                strings.scanQrTitle,
                style: CosmosTextTheme.title1Bold.copyWith(color: theme.colors.background),
              ),
              const Spacer(),
              _infoBox(theme),
              SizedBox(height: theme.spacingXXL),
              CosmosElevatedButton(
                onTap: widget.onTapShowQr,
                text: strings.showQrAction,
                backgroundColor: theme.colors.background,
                textColor: theme.colors.text,
              ),
              MinimalBottomSpacer(padding: theme.spacingXL)
            ],
          ),
        )
      ],
    );
  }

  Row _infoBox(CosmosThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacingXXL),
            child: Container(
              padding: EdgeInsets.all(theme.spacingL),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: theme.colors.inactive.withOpacity(0.5),
              ),
              child: Column(
                children: [
                  Text(
                    strings.scanAddressHelperText,
                    textAlign: TextAlign.center,
                    style: CosmosTextTheme.copy0Normal.copyWith(color: theme.colors.background),
                  ),
                  SizedBox(height: theme.spacingL),
                  Text(
                    strings.walletConnectHelperText,
                    textAlign: TextAlign.center,
                    style: CosmosTextTheme.copy0Normal.copyWith(color: theme.colors.background),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _headerButtons(CosmosThemeData theme) {
    return Row(
      children: [
        CosmosBackButton(
          text: '',
          onTap: widget.onTapClose,
          color: theme.colors.background,
        ),
        const Spacer(),
        InkWell(
          child: Image.asset(Assets.imagesFlash.path),
          onTap: () => _controller.toggleFlash(),
        ),
        SizedBox(width: theme.spacingXL)
      ],
    );
  }

  Widget _qrView(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 30,
        borderWidth: 0,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      widget.onQrScanned(scanData.toDomain);
      controller.dispose();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
