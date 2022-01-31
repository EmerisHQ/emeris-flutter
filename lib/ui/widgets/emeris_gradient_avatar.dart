import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmerisGradientAvatar extends StatelessWidget {
  const EmerisGradientAvatar({
    required this.onTap,
    required this.address,
    Key? key,
    this.height = 35,
  }) : super(key: key);

  final String address;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(CosmosTheme.of(context).spacingL),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: height,
          child: InkWell(onTap: onTap, child: GradientAvatar(stringKey: address)),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('address', address))
      ..add(DoubleProperty('height', height))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}
