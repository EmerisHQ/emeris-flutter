import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextInCircle extends StatelessWidget {
  const TextInCircle({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Color(0xffe88cfe),
            Color(0xff375df1),
            Color(0xffa4faff),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CosmosTheme.of(context).colors.background,
          ),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('text', text));
  }
}
