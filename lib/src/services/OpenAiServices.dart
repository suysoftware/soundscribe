import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:soundscribe/src/model/ChatGptModel.dart';

class OpenAiServices {
  static Future<String> audioSender(bool isTranslate, String audioPath) async {
    var file = File(audioPath);
    String fileName =
        audioPath.substring(audioPath.lastIndexOf('/') + 1, audioPath.length);

    var uri;

    if (isTranslate) {
      uri = Uri.parse(dotenv.env['WHISPER_TRANSLATION_API'].toString());
    } else {
      uri = Uri.parse(dotenv.env['WHISPER_TRANSCRIPTION_API'].toString());
    }

    String model = 'whisper-1';

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'Authorization': 'Bearer ${dotenv.env['OPEN_AI_API_KEY'].toString()}',
      'Content-Type': 'multipart/form-data',
    });
    request.fields.addAll({
      'model': model,
    });

    request.files.add(await http.MultipartFile.fromPath('file', file.path,
        filename: fileName, contentType: MediaType('audio', 'm4a')));

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseBody);

      return responseJson['text'].toString();

      // Handle successful response
    } else {
      return "Error";
      // Handle error response
    }
  }

    static Future<ChatGptModel> openAiQuestionRequest(String prompt) async {

    const endpoint = 'https://api.openai.com/v1/completions';
    var client = http.Client();
    var uri = Uri.parse(endpoint);
    var payload = jsonEncode({
      "model": "text-davinci-003",
      "prompt": prompt,
      "temperature": 0,
      "max_tokens": 200
    });
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${dotenv.env['OPEN_AI_API_KEY'].toString()}",
    };
    var response = await client.post(
      uri,
      headers: header,
      body: payload,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var cgptModel = chatGptModelFromJson(response.body);
      return cgptModel;
    } else {
      throw Exception('Failed to generate response.');
    }
  }


}
