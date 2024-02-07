import 'package:dictionary/features/dictionary/domain/word_definition.dart';

abstract class DictionaryRepository {
  /// Retrieves the definition of a word from the dictionary.
  ///
  /// Returns the [WordDefinition] object containing the definition of the word
  /// specified by [searchText]. If the word is not found in the dictionary,
  /// returns `null`.
  ///
  /// The [searchText] parameter is the word to search for in the dictionary.
  ///
  /// Throws an exception if there is an error while retrieving the definition.
  Future<WordDefinition?> getDefinition(String searchText);

  /// Initializes the dictionary repository.
  ///
  /// This method is responsible for initializing the dictionary repository.
  /// It should be called before any other operations are performed on the repository.
  ///
  /// Throws an exception if initialization fails.
  Future<void> init();
}
