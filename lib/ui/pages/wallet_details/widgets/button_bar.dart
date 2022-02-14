import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class CosmosButtonBar extends StatelessWidget {
  const CosmosButtonBar({
    required this.onTapReceive,
    required this.onTapSend,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapSend;
  final VoidCallback onTapReceive;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: CosmosElevatedButton(
            onTap: onTapReceive,
            text: strings.receiveAction,
          ),
        ),
        SizedBox(width: theme.spacingM),
        Expanded(
          child: CosmosOutlineButton(
            text: strings.sendAction,
            onTap: onTapSend,
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onSendPressed', onTapSend))
      ..add(ObjectFlagProperty<VoidCallback>.has('onReceivePressed', onTapReceive));
  }
}
