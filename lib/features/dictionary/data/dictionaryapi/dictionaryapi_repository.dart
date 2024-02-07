import 'dart:convert';

import 'package:dictionary/features/dictionary/data/dictionary_repository.dart';
import 'package:dictionary/features/dictionary/data/dictionaryapi/dictionaryapi_models.dart';
import 'package:dictionary/features/dictionary/domain/word_definition.dart';
import 'package:dictionary/features/dictionary/domain/word_meaning.dart';
import 'package:dictionary/main.dart';
import 'package:http/http.dart' as http;

class DictionaryApiRepository extends DictionaryRepository {
  @override
  Future<WordDefinition?> getDefinition(String searchText) async {
    // https://dictionaryapi.dev/

    // TODO. sanitize url (and/or validate the format of the search text)
    String url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$searchText';
    logger.d('getDefinition, url: $url');

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dictionaryApiModel = DictionaryApiModel.fromJson(json[0]);

      // TODO. create a dedicated mapping methdod.
      List<WordMeaning> meanings = [];

      for (Meanings meaning in dictionaryApiModel.meanings ?? []) {
        List<String> definitions = [];

        for (Definitions definition in meaning.definitions ?? []) {
          definitions.add(definition.definition ?? 'unknown definition');
        }

        var wordMeaning = WordMeaning(
          partOfSpeach: meaning.partOfSpeech ?? 'unknown part of speech',
          partDefinitions: definitions,
        );

        meanings.add(wordMeaning);
      }

      return Future.value(WordDefinition(word: searchText, meanings: meanings));
    }
    if (response.statusCode == 404) {
      try {
        var json = jsonDecode(response.body);
        var dictionaryApiNoResultsModel =
            DictionaryApiNoResultsModel.fromJson(json);
        logger.d(
            'getDefinition 404, parsed: ${dictionaryApiNoResultsModel.message}');

        return Future.value(null);
      } catch (e) {
        logger.e('getDefinition 404, not parsed: ${e.toString()}');
        throw Exception('No results could be found at this time');
      }
    } else {
      logger.e(
          'getDefinition, non standard response code ${response.statusCode.toString()}');

      throw Exception('Unknown error occurred.');
    }
  }

  @override
  Future<void> init() async {
    return Future.value();
  }
}
