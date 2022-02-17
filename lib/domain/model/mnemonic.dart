import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:equatable/equatable.dart';

class Mnemonic extends Equatable {
  const Mnemonic({
    required this.words,
  });

  Mnemonic.fromString(String mnemonic)
      : words = mnemonic
            .split(RegExp(r'\s+')) //
            .where((element) => element.isNotEmpty)
            .mapIndexed((index, word) => MnemonicWord(index: index, word: word))
            .toList();

  static const numberOfWords = [12, 14];
  final List<MnemonicWord> words;

  String get stringRepresentation => words.map((it) => it.word).join(' ');

  @override
  List<Object> get props => [
        words,
      ];

  List<String> get stringWords => words.map((e) => e.word).toList();

  bool get isEnoughWords => numberOfWords.contains(words.length);

  List<MnemonicWord> filteredOutSelectedWords(List<MnemonicWord> selectedWords) => words
      .map(
        (e) => selectedWords.contains(e) //
            ? MnemonicWord(index: e.index, word: '')
            : e,
      )
      .toList();

  bool isWordsOrderValid({required Iterable<MnemonicWord> selectedWords}) => selectedWords //
      .mapIndexed((index, selectedWord) => selectedWord == words[index])
      .every((isTrue) => isTrue);

  Mnemonic byShufflingWords() => Mnemonic(words: [...words]..shuffle());
}

class MnemonicWord extends Equatable {
  const MnemonicWord({
    required this.index,
    required this.word,
  });

  final int index;
  final String word;

  @override
  List<Object> get props => [
        index,
        word,
      ];
}
