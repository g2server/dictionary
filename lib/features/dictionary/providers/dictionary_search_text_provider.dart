import 'package:dictionary/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dictionary_search_text_provider.g.dart';

@Riverpod(keepAlive: true)
class DictionarySearchText extends _$DictionarySearchText {
  @override
  String build() {
    return '';
  }

  void updateText(String text) {
    logger.d('dictionarySearchTextProvider updateText: $text');
    state = text;
  }
}
