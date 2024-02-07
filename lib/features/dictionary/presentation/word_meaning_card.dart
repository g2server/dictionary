import 'package:dictionary/features/dictionary/domain/word_meaning.dart';
import 'package:flutter/material.dart';

class WordMeaningCard extends StatelessWidget {
  const WordMeaningCard({
    super.key,
    required this.wordMeaning,
  });
  final WordMeaning wordMeaning;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(wordMeaning.partOfSpeach),
        subtitle: Builder(builder: (context) {
          List<Widget> children = [];
          for (var i = 0; i < wordMeaning.partDefinitions.length; i++) {
            children.add(
              Text('${i + 1}. ${wordMeaning.partDefinitions[i]}'),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        }),
      ),
    );
  }
}
