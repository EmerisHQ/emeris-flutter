import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';

class BulletPointMessage extends StatelessWidget {
  final String message;

  const BulletPointMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colors.inactive),
        ),
        SizedBox(width: theme.spacingM),
        Expanded(child: Text(message)),
      ],
    );
  }
}
