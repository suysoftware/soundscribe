// To parse this JSON data, do
//
//     final chatGptTurboModel = chatGptTurboModelFromJson(jsonString);

import 'dart:convert';

ChatGptTurboModel chatGptTurboModelFromJson(String str) => ChatGptTurboModel.fromJson(json.decode(str));

String chatGptTurboModelToJson(ChatGptTurboModel data) => json.encode(data.toJson());

class ChatGptTurboModel {
    ChatGptTurboModel({
        required this.id,
        required this.object,
        required this.created,
        required this.choices,
        required this.usage,
    });

    String id;
    String object;
    int created;
    List<Choice> choices;
    Usage usage;

    factory ChatGptTurboModel.fromJson(Map<String, dynamic> json) => ChatGptTurboModel(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        usage: Usage.fromJson(json["usage"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
    };
}

class Choice {
    Choice({
        required this.index,
        required this.message,
        required this.finishReason,
    });

    int index;
    Message message;
    String finishReason;

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        index: json["index"],
        message: Message.fromJson(json["message"]),
        finishReason: json["finish_reason"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "message": message.toJson(),
        "finish_reason": finishReason,
    };
}

class Message {
    Message({
        required this.role,
        required this.content,
    });

    String role;
    String content;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
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
