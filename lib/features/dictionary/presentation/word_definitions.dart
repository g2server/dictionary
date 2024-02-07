import 'package:dictionary/features/dictionary/presentation/word_meaning_card.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_definition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordDefinitions extends ConsumerWidget {
  const WordDefinitions({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncValue = ref.watch(dictionaryDefinitionProvider);

        return asyncValue.when(
          data: (value) {
            if (value == null) {
              return const Center(
                child: Text('No results'),
              );
            } else {
              return ListView.builder(
                itemCount: value.meanings.length,
                itemBuilder: (context, index) {
                  return WordMeaningCard(
                    wordMeaning: value.meanings[index],
                  );
                },
              );
            }
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text('Error: $error'),
            );
          },
        );
      },
    );
  }
}
