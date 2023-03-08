// To parse this JSON data, do
//
//     final chatGptEditModel = chatGptEditModelFromJson(jsonString);

import 'dart:convert';

ChatGptEditModel chatGptEditModelFromJson(String str) => ChatGptEditModel.fromJson(json.decode(str));

String chatGptEditModelToJson(ChatGptEditModel data) => json.encode(data.toJson());

class ChatGptEditModel {
    ChatGptEditModel({
        required this.object,
        required this.created,
        required this.choices,
        required this.usage,
    });

    String object;
    int created;
    List<Choice> choices;
    Usage usage;

    factory ChatGptEditModel.fromJson(Map<String, dynamic> json) => ChatGptEditModel(
        object: json["object"],
        created: json["created"],
        choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        usage: Usage.fromJson(json["usage"]),
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "created": created,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
    };
}

class Choice {
    Choice({
        required this.text,
        required this.index,
    });

    String text;
    int index;

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        text: json["text"],
        index: json["index"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "index": index,
    };
}

class Usage {
    Usage({
        required this.promptTokens,
        required this.completionTokens,
        required this.totalTokens,
    });

    int promptTokens;
    int completionTokens;
    int totalTokens;

    factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
    );

    Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
    };
}
