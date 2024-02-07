class DictionaryApiModel {
  String? word;
  List<Meanings>? meanings;

  DictionaryApiModel({
    this.word,
    this.meanings,
  });

  DictionaryApiModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];

    if (json['meanings'] != null) {
      meanings = <Meanings>[];
      json['meanings'].forEach((v) {
        meanings!.add(Meanings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;

    if (meanings != null) {
      data['meanings'] = meanings!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Meanings {
  String? partOfSpeech;
  List<Definitions>? definitions;

  Meanings({this.partOfSpeech, this.definitions});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    if (json['definitions'] != null) {
      definitions = <Definitions>[];
      json['definitions'].forEach((v) {
        definitions!.add(Definitions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partOfSpeech'] = partOfSpeech;
    if (definitions != null) {
      data['definitions'] = definitions!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Definitions {
  String? definition;

  Definitions({this.definition});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;

    return data;
  }
}

class DictionaryApiNoResultsModel {
  String? title;
  String? message;
  String? resolution;

  DictionaryApiNoResultsModel({this.title, this.message, this.resolution});

  DictionaryApiNoResultsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    resolution = json['resolution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['resolution'] = resolution;
    return data;
  }
}
