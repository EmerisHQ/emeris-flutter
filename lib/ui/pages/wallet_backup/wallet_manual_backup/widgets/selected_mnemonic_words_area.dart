import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:cosmos_utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';
import 'package:flutter_app/utils/strings.dart';

class SelectedMnemonicWordsArea extends StatelessWidget {
  const SelectedMnemonicWordsArea({
    required this.selectedWords,
    required this.onTapWord,
    required this.isValid,
    Key? key,
  }) : super(key: key);

  final List<MnemonicWord> selectedWords;
  final void Function(int index)? onTapWord;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.spacingM),
          child: Stack(
            children: [
              Wrap(
                spacing: theme.spacingS,
                runSpacing: theme.spacingS,
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
                          color: theme.colors.error,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<MnemonicWord>('selectedWords', selectedWords))
      ..add(ObjectFlagProperty<void Function(int index)?>.has('onTapWord', onTapWord))
      ..add(DiagnosticsProperty<bool>('isValid', isValid));
  }
}
