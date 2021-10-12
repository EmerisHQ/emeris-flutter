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
    return Padding(
      padding: const EdgeInsets.all(CosmosAppTheme.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: CosmosElevatedButton(onTap: () {}, text: strings.receiveAction)),
          const SizedBox(width: CosmosAppTheme.spacingM),
          Expanded(child: CosmosOutlineButton(text: strings.sendAction, onTap: onSendPressed)),
        ],
      ),
    );
  }
}
