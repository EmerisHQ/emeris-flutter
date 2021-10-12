import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

enum BackupLaterConfirmationResult {
  backupNow,
  skipBackup,
}

class BackupLaterConfirmationSheet extends StatefulWidget {
  const BackupLaterConfirmationSheet({Key? key}) : super(key: key);

  @override
  State<BackupLaterConfirmationSheet> createState() => _BackupLaterConfirmationSheetState();
}

class _BackupLaterConfirmationSheetState extends State<BackupLaterConfirmationSheet> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CosmosAppTheme.spacingL,
        vertical: CosmosAppTheme.spacingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            strings.walletSkipBackupConfirmationTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: CosmosAppTheme.spacingL),
          CheckboxListTile(
            onChanged: (value) => setState(() => checked = !checked),
            value: checked,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(strings.walletSkipBackupConfirmationMessage),
          ),
          const SizedBox(height: CosmosAppTheme.spacingL),
          CosmosElevatedButton(
            text: strings.continueAction,
            onTap: checked //
                ? () => Navigator.of(context).pop(BackupLaterConfirmationResult.skipBackup)
                : null,
          ),
          CosmosOutlineButton(
            text: strings.backUpNowAction,
            onTap: () => Navigator.of(context).pop(BackupLaterConfirmationResult.backupNow),
          ),
        ],
      ),
    );
  }
}

abstract class BackupLaterConfirmationRoute {
  BuildContext get context;

  Future<BackupLaterConfirmationResult> openBackupLaterConfirmation() async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) => const BackupLaterConfirmationSheet(),
    ) as BackupLaterConfirmationResult?;
    return result ?? BackupLaterConfirmationResult.backupNow;
  }
}
