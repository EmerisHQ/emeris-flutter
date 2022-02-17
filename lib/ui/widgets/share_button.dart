import 'dart:io';

import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = CosmosTheme.of(context).colors.link;
    return CosmosTextButton(
      onTap: onTap,
      leadingIcon: Icon(
        Platform.isIOS ? CupertinoIcons.share : Icons.share,
        color: color,
      ),
      text: strings.shareAction,
      color: color,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
  }
}
