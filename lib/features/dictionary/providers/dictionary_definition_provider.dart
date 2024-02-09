import 'package:dictionary/features/auth/providers/auth_state_provider.dart';
import 'package:dictionary/features/dictionary/data/dictionary_repository.dart';
import 'package:dictionary/features/dictionary/domain/word_definition.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_provider.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_search_text_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_definition_provider.g.dart';

@riverpod
Future<WordDefinition?> dictionaryDefinition(
    DictionaryDefinitionRef ref) async {
  ref.watch(authStateProvider);
  var searchText = ref.watch(dictionarySearchTextProvider);
  if (searchText.isEmpty) {
    return Future.value(null);
  }
  //await Future<void>.delayed(const Duration(seconds: 1));
  DictionaryRepository repo =
      ref.watch(dictionaryRepositoryProvider).requireValue;

  var definition = await repo.getDefinition(searchText);
  return Future.value(definition);
}
