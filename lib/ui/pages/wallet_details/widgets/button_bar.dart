import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class CosmosButtonBar extends StatelessWidget {
  final VoidCallback onSendPressed;
  final VoidCallback onReceivePressed;

  const CosmosButtonBar({
    Key? key,
    required this.onReceivePressed,
    required this.onSendPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacingM),
      child: Row(
        children: [
          Expanded(child: CosmosElevatedButton(onTap: () {}, text: strings.receiveAction)),
          SizedBox(width: theme.spacingM),
          Expanded(child: CosmosOutlineButton(text: strings.sendAction, onTap: onSendPressed)),
        ],
      ),
    );
  }
}
