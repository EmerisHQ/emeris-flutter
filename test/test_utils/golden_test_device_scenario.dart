import 'package:alchemist/alchemist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Wrapper for testing widgets (primarily screens) with device constraints
class GoldenTestDeviceScenario extends StatelessWidget {
  const GoldenTestDeviceScenario({
    required this.builder,
    required this.device,
    this.suffix,
    Key? key,
  }) : super(key: key);

  final Device device;
  final String? suffix;
  final ValueGetter<Widget> builder;

  @override
  Widget build(BuildContext context) {
    return GoldenTestScenario(
      name: device.name + (suffix == null ? '' : '_$suffix'),
      child: ClipRect(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: device.size,
            padding: device.safeArea,
            platformBrightness: device.brightness,
            devicePixelRatio: device.devicePixelRatio,
            textScaleFactor: device.textScale,
          ),
          child: SizedBox(
            height: device.size.height,
            width: device.size.width,
            child: builder(),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Device>('device', device))
      ..add(ObjectFlagProperty<ValueGetter<Widget>>.has('builder', builder))
      ..add(StringProperty('suffix', suffix));
  }
}
