import 'dart:math';

import 'package:dictionary/features/dictionary/data/mock_dictionary_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'mock repository getDefinition valid word',
    (tester) async {
      final repository = MockDictionaryRepository();
      const searchText = 'someword';

      final wordDefinition = await repository.getDefinition(searchText);

      expect(wordDefinition, isNotNull);
      expect(wordDefinition!.word, searchText);
      expect(wordDefinition.meanings.length, 3);
    },
  );

  testWidgets(
    'mock repository getDefinition blank search',
    (tester) async {
      final repository = MockDictionaryRepository();
      const searchText = '';

      final wordDefinition = await repository.getDefinition(searchText);

      expect(wordDefinition, isNull);
    },
  );

  testWidgets(
    'mock repository getDefinition no results',
    (tester) async {
      final repository = MockDictionaryRepository();
      const searchText = 'no_results';

      final wordDefinition = await repository.getDefinition(searchText);

      expect(wordDefinition, isNull);
    },
  );

  // TODO. complete the test
  // testWidgets(
  //   'mock repository getDefinition exception',
  //   (tester) async {
  //     final repository = MockDictionaryRepository();
  //     const searchText = 'simulate_exception';

  //     final wordDefinition = await repository.getDefinition(searchText);

  //     expect(tester.takeException(), isNotNull);
  //   },
  //);
}
