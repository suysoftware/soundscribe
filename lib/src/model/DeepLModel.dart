// To parse this JSON data, do
//
//     final deepLModel = deepLModelFromJson(jsonString);

import 'dart:convert';

DeepLModel deepLModelFromJson(String str) => DeepLModel.fromJson(json.decode(str));

String deepLModelToJson(DeepLModel data) => json.encode(data.toJson());

class DeepLModel {
    DeepLModel({
        required this.translations,
    });

    List<Translation> translations;

    factory DeepLModel.fromJson(Map<String, dynamic> json) => DeepLModel(
        translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
    };
}

class Translation {
    Translation({
        required this.detectedSourceLanguage,
        required this.text,
    });

    String detectedSourceLanguage;
    String text;

    factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        detectedSourceLanguage: json["detected_source_language"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "detected_source_language": detectedSourceLanguage,
        "text": text,
    };
}
