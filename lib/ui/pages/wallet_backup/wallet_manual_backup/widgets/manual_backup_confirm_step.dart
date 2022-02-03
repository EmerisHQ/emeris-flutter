import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/wallet_manual_backup_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_backup/wallet_manual_backup/widgets/selected_mnemonic_words_area.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ManualBackupConfirmStep extends StatelessWidget {
  const ManualBackupConfirmStep({
    required this.model,
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final WalletManualBackupViewModel model;
  final WalletManualBackupPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
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
                    SizedBox(height: theme.spacingL),
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<WalletManualBackupViewModel>('model', model))
      ..add(DiagnosticsProperty<WalletManualBackupPresenter>('presenter', presenter));
  }
}
