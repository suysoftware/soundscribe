   import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
Future<File> downloadAndSaveImage(String url) async {
  final response = await http.get(Uri.parse(url));
  final appDir = await getDownloadsDirectory();
  final fileName = url.split('/').last+".png";
  final file = File('${appDir!.path}/$fileName');
  await file.writeAsBytes(response.bodyBytes);
  return file;
}