import 'package:cosmos_ui_components/components/mnemonic_choice_chip.dart';
import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:cosmos_utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';
import 'package:flutter_app/utils/strings.dart';

class SelectedMnemonicWordsArea extends StatelessWidget {
  final List<MnemonicWord> selectedWords;
  final void Function(int index)? onTapWord;
  final bool isValid;

  const SelectedMnemonicWordsArea({
    Key? key,
    required this.selectedWords,
    required this.onTapWord,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(CosmosAppTheme.spacingM),
          child: Stack(
            children: [
              Wrap(
                spacing: CosmosAppTheme.spacingS,
                runSpacing: CosmosAppTheme.spacingS,
                children: selectedWords //
                    .mapIndexed(
                      (index, it) => MnemonicChoiceChip(
                        index: index,
                        word: it.word,
                        showIndex: false,
                        onTap: onTapWord == null ? null : () => onTapWord?.call(index),
                      ),
                    )
                    .toList(),
              ),
              if (!isValid)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Text(
                    strings.invalidOrderMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: CosmosColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
