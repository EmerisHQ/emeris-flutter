import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    final theme = CosmosTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacingL,
        vertical: theme.spacingXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            strings.accountSkipBackupConfirmationTitle,
            textAlign: TextAlign.center,
            style: CosmosTextTheme.title1Bold.copyWith(color: theme.colors.text),
          ),
          SizedBox(
            height: CosmosTheme.of(context).spacingXXL,
          ),
          CosmosCheckboxTile(
            text: strings.accountSkipBackupConfirmationMessage,
            onTap: () => setState(() => checked = !checked),
            checked: checked,
          ),
          SizedBox(
            height: CosmosTheme.of(context).spacingM,
          ),
          SizedBox(height: theme.spacingL),
          CosmosElevatedButton(
            text: strings.continueAction,
            onTap: checked //
                ? () => Navigator.of(context).pop(BackupLaterConfirmationResult.skipBackup)
                : null,
          ),
          SizedBox(
            height: CosmosTheme.of(context).spacingM,
          ),
          CosmosOutlineButton(
            text: strings.backUpNowAction,
            onTap: () => Navigator.of(context).pop(BackupLaterConfirmationResult.backupNow),
          ),
          const MinimalBottomSpacer(),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('checked', checked));
  }
}

abstract class BackupLaterConfirmationRoute {
  BuildContext get context;

  Future<BackupLaterConfirmationResult> openBackupLaterConfirmation() async {
    final result = await showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const CosmosBottomSheetContainer(
        child: BackupLaterConfirmationSheet(),
      ),
    ) as BackupLaterConfirmationResult?;
    return result ?? BackupLaterConfirmationResult.backupNow;
  }
}
