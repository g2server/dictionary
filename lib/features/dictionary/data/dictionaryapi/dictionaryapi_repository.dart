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

    const baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';
    final url = baseUrl + searchText.trim();
    logger.d('getDefinition, url: $url');

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var wordDefinition = _parseAndMap200(response.body, searchText);
      return Future.value(wordDefinition);
    }
    if (response.statusCode == 404) {
      _parseAndMap404(response.body);
      return Future.value(null);
    } else {
      logger.e(
          'getDefinition, non standard response code ${response.statusCode.toString()}');

      throw Exception('Unknown error occurred.');
    }
  }

  void _parseAndMap404(String jsonText) {
    try {
      var json = jsonDecode(jsonText);
      var dictionaryApiNoResultsModel =
          DictionaryApiNoResultsModel.fromJson(json);
      logger.d(
          'getDefinition 404, parsed: ${dictionaryApiNoResultsModel.message}');

      return;
    } catch (e) {
      // This could indicate a change in the API response format, or a non-planned 404 response, eg server error.
      logger.e('getDefinition 404, not parsed: ${e.toString()}');
      throw Exception('No results could be found at this time');
    }
  }

  WordDefinition _parseAndMap200(String jsonText, String word) {
    var json = jsonDecode(jsonText);
    var dictionaryApiModel = DictionaryApiModel.fromJson(json[0]);

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

    return WordDefinition(word: word, meanings: meanings);
  }

  @override
  Future<void> init() async {
    // TODO. Could be used to check if the API is available.
    return Future.value();
  }
}
