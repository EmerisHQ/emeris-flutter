import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/widgets/selected_mnemonic_words_area.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ManualBackupConfirmStep extends StatelessWidget {
  const ManualBackupConfirmStep({
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      strings.writeRecoveryPhraseTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SelectedMnemonicWordsArea(
                      selectedWords: model.selectedWords,
                      onTapWord: presenter.onTapSelectedWord,
                      isValid: model.isWordsOrderValid,
                    ),
                    const SizedBox(height: CosmosAppTheme.spacingL),
                    CosmosMnemonicWordsGrid(
                      physics: const NeverScrollableScrollPhysics(),
                      showIndices: false,
                      mnemonicWords: model.filteredOutSelectedWords.map((e) => e.word).toList(),
                      onTapWord: presenter.onTapUnselectedWord,
                    ),
                  ],
                ),
              ),
            ),
            CosmosElevatedButton(
              text: strings.continueAction,
              onTap: model.mnnemonicConfirmationValid //
                  ? presenter.onTapConfirmContinue
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}