import 'dart:convert';
import 'package:deepl_dart/deepl_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soundscribe/src/model/DeepLModel.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class DeepLServices {
  static Future<String> deepLTranslateRequest(String prompt) async {

    const endpoint = 'https://api.deepl.com/v2/translate';
    var client = http.Client();
    var uri = Uri.parse(endpoint);
    var payload = jsonEncode({
      "text": prompt,
      "target_lang": "EN",
      
    });
    var header = {
      'Authorization':"DeepL-Auth-Key ${dotenv.env['DeepL_API_KEY'].toString()}",
    };

    var response = await client.post(
      uri,
      body: payload,headers: header
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = utf8.decode(response.bodyBytes);
      print(data);
      var deepLItem = deepLModelFromJson(utf8.decode(response.bodyBytes));
      return deepLItem.translations.first.text;
    } else {
      print("fail");
      throw Exception('Failed to generate response.');
    }
  }
}
