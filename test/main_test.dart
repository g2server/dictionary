import 'package:dictionary/app.dart';
import 'package:dictionary/features/dictionary/data/mock_dictionary_repository.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Main sign in test', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dictionaryRepositoryProvider.overrideWithValue(
            MockDictionaryRepository(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    // TODO, complete the test
  });
}
