import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/account_backup/account_manual_backup/account_manual_backup_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ManualBackupIntroStep extends StatelessWidget {
  const ManualBackupIntroStep({
    required this.model,
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final AccountManualBackupViewModel model;
  final AccountManualBackupPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
      child: Observer(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.recoveryPhraseTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: theme.spacingM),
            Text(
              strings.backUpYourAccountMessage,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            CosmosMnemonicWordsGrid(
              physics: const NeverScrollableScrollPhysics(),
              mnemonicWords: model.mnemonicStringWords,
            ),
            CosmosTextButton(
              suffixIcon: const Icon(Icons.copy),
              text: strings.copyToClipboardAction,
              onTap: presenter.onTapCopyToClipboard,
            ),
            const Spacer(),
            CheckboxListTile(
              onChanged: (checked) => presenter.onCheckConfirmationCheckbox(checked ?? false),
              value: model.confirmationChecked,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(strings.recoveryPhraseCheckbox),
            ),
            SizedBox(height: theme.spacingL),
            CosmosElevatedButton(
              text: strings.continueAction,
              onTap: model.confirmationChecked //
                  ? presenter.onTapIntroContinue
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AccountManualBackupViewModel>('model', model))
      ..add(DiagnosticsProperty<AccountManualBackupPresenter>('presenter', presenter));
  }
}
