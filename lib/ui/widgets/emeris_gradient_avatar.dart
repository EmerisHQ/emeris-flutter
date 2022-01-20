import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';

class EmerisGradientAvatar extends StatelessWidget {
  final String address;
  final double height;
  final VoidCallback onTap;

  const EmerisGradientAvatar({
    Key? key,
    required this.address,
    this.height = 35,
    required this.onTap,
  }) : super(key: key);

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
}
