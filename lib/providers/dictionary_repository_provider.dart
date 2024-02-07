import 'package:dictionary/features/dictionary/data/dictionary_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_repository_provider.g.dart';

@riverpod
DictionaryRepository dictionaryRepository(DictionaryRepositoryRef ref) {
  // note: this is being eagerly initialized in main
  throw UnimplementedError();
}
