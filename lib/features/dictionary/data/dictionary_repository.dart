import 'package:dictionary/features/dictionary/domain/word_definition.dart';

abstract class DictionaryRepository {
  Future<WordDefinition?> getDefinition(String searchText);

  Future<void> init();
}
