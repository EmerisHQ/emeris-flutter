import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DenomIcon extends StatelessWidget {
  const DenomIcon({
    required this.url,
    Key? key,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    //TODO display proper denom icon here
    return const Icon(Icons.monetization_on);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('url', url));
  }
}
