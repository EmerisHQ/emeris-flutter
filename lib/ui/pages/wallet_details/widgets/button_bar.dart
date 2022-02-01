import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class CosmosButtonBar extends StatelessWidget {
  const CosmosButtonBar({
    required this.onReceivePressed,
    required this.onSendPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onSendPressed;
  final VoidCallback onReceivePressed;

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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onSendPressed', onSendPressed))
      ..add(ObjectFlagProperty<VoidCallback>.has('onReceivePressed', onReceivePressed));
  }
}
