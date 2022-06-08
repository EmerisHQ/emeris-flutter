import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TestAppWidget extends StatelessWidget {
  const TestAppWidget({
    required this.child,
    required this.themeData,
    Key? key,
  }) : super(key: key);

  final CosmosThemeData themeData;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CosmosTheme(
      themeData: themeData,
      child: Builder(
        builder: (context) {
          return Theme(
            data: CosmosTheme.of(context).buildFlutterTheme(),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<CosmosThemeData>('themeData', themeData));
  }
}
