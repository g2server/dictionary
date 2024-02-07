import 'package:dictionary/features/dictionary/data/dictionary_repository.dart';
import 'package:dictionary/features/dictionary/domain/word_definition.dart';
import 'package:dictionary/features/dictionary/domain/word_meaning.dart';

class MockDictionaryRepository extends DictionaryRepository {
  @override
  Future<WordDefinition> getDefinition(String searchText) {
    List<WordMeaning> meanings = [];
    for (int i = 0; i < 3; i++) {
      var word = WordMeaning(
        partOfSpeach: 'partOfSpeach $i',
        partDefinitions: ['definition $i'],
      );
      meanings.add(word);
    }
    return Future.value(WordDefinition(word: searchText, meanings: meanings));
  }

  @override
  Future<void> init() async {
    //await Future<void>.delayed(const Duration(seconds: 1));
    return Future.value();
  }
}
