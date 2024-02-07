import 'package:dictionary/features/dictionary/domain/word_meaning.dart';

class WordDefinition {
  String word;
  List<WordMeaning> meanings;
  WordDefinition({
    required this.word,
    required this.meanings,
  });
}
