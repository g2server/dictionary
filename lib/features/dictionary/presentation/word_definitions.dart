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
                  return ListTile(
                    title: Text(value.meanings[index].partOfSpeach),
                    subtitle: Builder(builder: (context) {
                      List<Widget> children = [];
                      for (var i = 0;
                          i < value.meanings[index].partDefinitions.length;
                          i++) {
                        children.add(
                          Text(
                              '${i + 1}. ${value.meanings[index].partDefinitions[i]}'),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      );
                    }),
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
