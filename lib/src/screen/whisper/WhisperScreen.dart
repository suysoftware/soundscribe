import "dart:convert";
import "dart:io";
import "package:flutter/services.dart";
import 'package:http/http.dart' as http;
import "package:flutter/cupertino.dart";
import "package:http_parser/http_parser.dart";
import "package:path_provider/path_provider.dart";
import "package:record/record.dart";
import "package:sizer/sizer.dart";
import "package:soundscribe/src/services/OpenAiServices.dart";


const openAIKey = "";
const endpointSpeechToText = "";
var audioPath = "";
var fileNamex = "";
const endpointSpeechToTranslate = "";
Future<void> transcribeAudio(String filePath, String model) async {
  var request = http.MultipartRequest('POST', Uri.parse(endpointSpeechToText));
  request.headers.addAll({
    'Authorization': 'Bearer $openAIKey',
    'Content-Type': 'multipart/form-data',
  });
  request.fields.addAll({
    'model': model,
  });
  request.files.add(http.MultipartFile.fromBytes(
      'file', (await rootBundle.load(filePath)).buffer.asUint8List(),
      filename: "myvoice.wav", contentType: MediaType('audio', 'wav')));

  var response = await request.send();
  print(response.statusCode);
  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    var responseJson = jsonDecode(responseBody);

    print(responseJson);

    // Handle successful response
    print('aha');
  } else {
    // Handle error response
  }
}

Future<void> translateAudio(String filePath, String model) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(endpointSpeechToTranslate));
  request.headers.addAll({
    'Authorization': 'Bearer $openAIKey',
    'Content-Type': 'multipart/form-data',
  });
  request.fields.addAll({
    'model': model,
  });
  request.files.add(http.MultipartFile.fromBytes(
      'file', (await rootBundle.load(filePath)).buffer.asUint8List(),
      filename: "myvoice.wav", contentType: MediaType('audio', 'wav')));

  var response = await request.send();
  print(response.statusCode);
  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    var responseJson = jsonDecode(responseBody);

    print(responseJson);

    // Handle successful response
    print('aha');
  } else {
    // Handle error response
  }
}

Future<void> testFunc() async {}

class WhisperScreen extends StatefulWidget {
  const WhisperScreen({super.key});

  @override
  State<WhisperScreen> createState() => _WhisperScreenState();
}

class _WhisperScreenState extends State<WhisperScreen> {
  final record = Record();

  var richText = "";

  Future<void> audioRecordStart() async {
// Check and request permission
    print('basladi');
    if (await record.hasPermission()) {
      // Start recording

      Directory directory = await getApplicationSupportDirectory();
      print(directory.path);
      String filepath = directory.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.m4a';
      print(filepath);
      try {
        await record.start(
          path: filepath,
          samplingRate: 44100,
          encoder: AudioEncoder.aacLc, // by default
          bitRate: 128000, // by default
        );
        audioPath = filepath;
        fileNamex = DateTime.now().millisecondsSinceEpoch.toString() + '.m4a';
      } catch (e) {
        print(e);
      }
    }

// Get the state of the recorder
  }

  Future<void> audioRecordStop() async {
    print('bitir');
    bool isRecording = await record.isRecording();
    if (isRecording) {
      print('yesrecording');
      await record.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
      ),
      child: Container(
        width: 100.w,
        color: CupertinoColors.white,
        child: Column(
          children: [
            CupertinoButton(
                child: Text('Whisper - Speech to Text (From File)'),
                onPressed: () async {
                  //var result = await whisperRequest();

                  //var file = File('assets/voices/myvoice.wav');
                  //var result = await whisperStreamRequest(file);

                  String filePath = 'assets/voices/myvoice.wav';
                  String model = 'whisper-1';
                  await transcribeAudio(filePath, model);
                  print('agaa');
                }),
            CupertinoButton(
                child: Text('Whisper - Speech to Translated Text(From File)'),
                onPressed: () async {
                  //var result = await whisperRequest();

                  //var file = File('assets/voices/myvoice.wav');
                  //var result = await whisperStreamRequest(file);

                  String filePath = 'assets/voices/myvoice-turkish.wav';
                  String model = 'whisper-1';
                  await translateAudio(filePath, model);
                  print('agaa');
                }),
            CupertinoButton(
                child: Text('Whisper - Recording Start'),
                onPressed: () async {
                  await audioRecordStart();
                }),
            CupertinoButton(
                child: Text('Whisper - Recording Stop'),
                onPressed: () async {
                  await audioRecordStop();
                }),
            CupertinoButton(
                child: Text('Whisper - Send Record Transcript'),
                onPressed: () async {
                  var result =
                      await OpenAiServices.audioSender(false, audioPath);
                  print(result);
                  setState(() {
                    richText = result;
                  });
                }),
            CupertinoButton(
                child: Text('Whisper - Send Record Translate'),
                onPressed: () async {
                  var result =
                      await OpenAiServices.audioSender(true, audioPath);
                  print(result);
                  setState(() {
                    richText = result;
                  });
                }),
            CupertinoButton(
                child: Text('test'),
                onPressed: () async {
                  await testFunc();
                }),
            Text(richText),
          ],
        ),
      ),
    );
  }
}
