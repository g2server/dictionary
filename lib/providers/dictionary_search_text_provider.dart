import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dictionary_search_text_provider.g.dart';

@riverpod
class DictionarySearchText extends _$DictionarySearchText {
  @override
  String build() {
    return '';
  }

  void updateText(String text) {
    state = text;
  }
}
