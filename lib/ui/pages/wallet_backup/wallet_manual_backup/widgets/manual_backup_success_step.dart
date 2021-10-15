import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class ManualBackupSuccessStep extends StatelessWidget {
  const ManualBackupSuccessStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, size: 128),
        const SizedBox(height: CosmosAppTheme.spacingL),
        Text(
          strings.walletCreatedSuccessMessage,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
