import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:flutter/material.dart';

class BulletPointMessage extends StatelessWidget {
  final String message;

  const BulletPointMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CosmosColors.lightInactive,
          ),
        ),
        const SizedBox(width: CosmosAppTheme.spacingM),
        Expanded(child: Text(message)),
      ],
    );
  }
}
