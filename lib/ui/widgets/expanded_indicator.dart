import 'package:cosmos_ui_components/utils/durations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpandedIndicator extends StatelessWidget {
  const ExpandedIndicator({
    required this.expanded,
    Key? key,
  }) : super(key: key);

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: expanded ? -0.25 : 0.25,
      duration: const ShortDuration(),
      child: const Icon(Icons.chevron_right),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<bool>('expanded', expanded));
  }
}
