import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ManualBackupIntroStep extends StatelessWidget {
  const ManualBackupIntroStep({
    Key? key,
    required this.model,
    required this.presenter,
  }) : super(key: key);

  final WalletManualBackupViewModel model;
  final WalletManualBackupPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CosmosAppTheme.spacingL),
      child: Observer(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.recoveryPhraseTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: CosmosAppTheme.spacingM),
            Text(
              strings.backUpYourWalletMessage,
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
            const SizedBox(
              height: CosmosAppTheme.spacingM,
            ),
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
}
