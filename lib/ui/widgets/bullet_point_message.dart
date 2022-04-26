import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BulletPointMessage extends StatelessWidget {
  const BulletPointMessage({
    required this.message,
    Key? key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacingL,
        vertical: theme.spacingXL,
      ),
      decoration: BoxDecoration(color: theme.colors.cardBackground, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colors.inactive),
          ),
          SizedBox(width: theme.spacingM),
          Expanded(
            child: Text(
              message,
              style: CosmosTextTheme.copyMinus1Normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
  }
}
