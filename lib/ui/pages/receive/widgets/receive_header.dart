import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class ReceiveHeader extends StatelessWidget {
  const ReceiveHeader({
    required this.onTapClose,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapClose;

  @override
  Widget build(BuildContext context) {
    return CosmosBottomSheetHeader(
      title: '',
      actions: [
        CosmosTextButton(
          text: strings.closeAction,
          onTap: onTapClose,
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<VoidCallback>.has('onTapClose', onTapClose));
  }
}
