import 'package:dictionary/features/dictionary/data/dictionary_repository.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_bootstrap_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_repository_provider.g.dart';

@riverpod
Future<DictionaryRepository> dictionaryRepository(
    DictionaryRepositoryRef ref) async {
  var provider = ref.watch(dictionaryRepositoryBootstrapProvider);
  await provider.init();
  return provider;
}
