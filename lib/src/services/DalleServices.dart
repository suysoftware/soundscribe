import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:soundscribe/src/model/DalleModel.dart';

class DalleServices {
  static Future<String> dalleGenerationsRequest(String prompt) async {




    const endpoint = 'https://api.openai.com/v1/images/generations';
    var client = http.Client();
    var uri = Uri.parse(endpoint);
    var payload = jsonEncode({"prompt": prompt, "n": 1, "size": "1024x1024"});
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${dotenv.env['OPEN_AI_API_KEY'].toString()}",
    };
    var response = await client.post(
      uri,
      headers: header,
      body: payload,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = utf8.decode(response.bodyBytes);

      var dalleModel = dalleModelFromJson(data);
      await Clipboard.setData(ClipboardData(text: dalleModel.data.first.url));

      return data;
    } else {
      throw Exception('Failed to generate response.');
    }
  }
/*
  static Future<String> dalleEditsRequest(
      bool isTranslate, String audioPath) async {}
  static Future<String> dalleVariationsRequest(
      bool isTranslate, String audioPath) async {}*/
}
