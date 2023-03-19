import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:background_downloader/background_downloader.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';

import 'package:sizer/sizer.dart';
import 'package:soundscribe/main.dart';
import 'package:soundscribe/src/screen/chat/ChatScreen.dart';
import 'package:soundscribe/src/screen/whisper/WhisperScreen.dart';
import 'package:soundscribe/src/services/DalleServices.dart';
import 'package:soundscribe/src/services/DeepLServices.dart';
import 'package:soundscribe/src/services/OpenAiServices.dart';
import 'package:soundscribe/src/utils/audio_recorder.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ClipboardListener {
  final FocusNode _focusNode = FocusNode();
  final record = Record();
  static const methodChannel = MethodChannel('soundscribe.suy/methods');
  static const statusBarMethodChannel =
      MethodChannel('soundscribe.suy/statusBarChannel');
  static const testMethodChannel = MethodChannel("soundscribe.suy/methodTest");
  int count = 0;
  String batteryLevel = 'Waiting...';
  String intentsResult = 'no-result';
  String clipboardText = "";
  String clipboardAnswer = "";

  void fastRequester(String task) async {
    /*var clipData = await Clipboard.getData(Clipboard.kTextPlain);
    print(clipData!.text.toString());

    var coppiedText;
    if (clipData != null) {
      coppiedText = clipData.text.toString();
    }
*/
    if (clipboardText == null || clipboardText == "" || clipboardText == " ") {
      print("clip empty");
    } else {
      var answer = await OpenAiServices.openAiChatRequest(
          '"' + clipboardText + '"' + task);
      
    }

    //await windowManager.setSize(Size(800, 600));
    //await windowManager.setAlignment(Alignment.topRight, animate: true);
  }

  @override
  void initState() {
    clipboardWatcher.addListener(this);
    // start watch
    clipboardWatcher.start();

    statusBarMethodChannel.setMethodCallHandler((methodCall) async {
      debugPrint(
          "CAUGHT METHOD WITH HANDLER: ${methodCall.method}"); // Never comes here
      switch (methodCall.method) {
        case "sBar/Dall-E":
          //debugPrint("Click 2 basti"); //
          var dalleResult =
              await DalleServices.dalleGenerationsRequest(clipboardText);

          return;
        case "sBar/DeepL":
          //debugPrint("Click 2 basti"); //
          var deepLResult =
              await DeepLServices.deepLTranslateRequest(clipboardText);

          print(deepLResult);

          return;
        case "sBar/Reply":
          //debugPrint("Click 2 basti"); //

          fastRequester("Bu maile cevap hazırla");

          return;
        case "sBar/xc1":
          //debugPrint("Click 1 basti"); // Never comes here
          fastRequester("Bu maile cevap hazırla");
          //await methodChannel.invokeMethod('firstTaskFinished');

          return;
        case "sBar/trans":
          //debugPrint("Click 2 basti"); //
          fastRequester("Bu maile ingilizce cevap hazırla");

          return;
        case "sBar/concl":
          print("budondu");
          //debugPrint("Click 2 basti"); //
          fastRequester("Bu metni özetle");
          return;

        case "fastAnswerTr":
          //debugPrint("Click 1 basti"); // Never comes here
          fastRequester("Bu maile cevap hazırla");
          await methodChannel.invokeMethod('firstTaskFinished');

          return;
        case "fastAnswerEn":
          //debugPrint("Click 2 basti"); //
          fastRequester("Bu maile ingilizce cevap hazırla");

          return;
        case "fastConclusion":
          //debugPrint("Click 2 basti"); //
          fastRequester("Bu metni özetle");
          return;
        default:
          throw MissingPluginException('Not Implemented'); // Never comes here
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    // stop watch
    clipboardWatcher.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.capsLock)) {
          print('basti');
          return KeyEventResult.handled;
        } else {
          return KeyEventResult.handled;
        }
      },
      child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGrey,
          child: Container(
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: Text('Battery Level'),
                  onPressed: getBatteryLevel,
                ),
                //Text('HOMEPAGE'),

                Text(batteryLevel),

                /*      CupertinoButton(
                    child: Text('clipboard'),
                    onPressed: () async {
                      var data = await getClipboardData();
                      setState(() {
                        clipboardText = data.toString();
                      });
                    }),*/

                /*  _voiceRecorder(),
                Text(clipboardAnswer),
                _fastMailBuild("Hızlı Yanıt - TR", "Bu maile cevap hazırla"),
                _fastMailBuild(
                    "Hızlı Yanıt - EN", "Bu maile ingilizce cevap hazırla"),
                _fastMailBuild("Özet", "Bu metni özetle"),*/

                CupertinoButton(
                    child: Text('intent test'), onPressed: getAppIntents),
                Text(intentsResult),
              ],
            ),
          )),
    );
  }

  Future getBatteryLevel() async {
    final arguments = {'name': 'Sarah Abs'};
    var newBatterLevel =
        await methodChannel.invokeMethod('getBatteryLevel', arguments);
    setState(() => batteryLevel = '$newBatterLevel%');
  }

  Future getAppIntents() async {
    final arguments = {'name': 'cabbar'};
    var newAppIntentResult =
        await methodChannel.invokeMethod('getAppIntents', arguments);
    setState(() => intentsResult = '=> $newAppIntentResult <=');
  }

  Future<String?> getClipboardData() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    return clipboardData!.text;
  }

// Clipboard'a veri yazmak için aşağıdaki kodu kullanabilirsiniz
  Future<void> setClipboardData(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
  }

  Widget _voiceRecorder() {
    return GestureDetector(
      child: Icon(CupertinoIcons.mic),
      onLongPress: () async {
        audioPath = (await AudioRecorder.audioRecordStart(record))!;
      },
      onLongPressEnd: (s) async {
        await AudioRecorder.audioRecordStop(record);

        var data = await getClipboardData();

        var result = await OpenAiServices.audioSender(false, audioPath);

        var answer = await OpenAiServices.openAiQuestionRequest(
            '"' + data.toString() + '"' + result);

        windowManager.setSize(Size(800, 600));
        windowManager.setAlignment(Alignment.topRight, animate: true);
        setState(() {
          clipboardAnswer = answer.choices.first.text;
        });
      },
    );
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    clipboardText = newClipboardData!.text.toString();
    //windowManager.restore();
    //print(newClipboardData?.text ?? "");
    //print("");
  }

  /* Widget _fastMailBuild(String taskName, String task) {
    return CupertinoButton(
        child: Text(task),
        onPressed: () async {
          var answer = await OpenAiServices.openAiQuestionRequest(
              '"' + clipboardText + '"' + task);

          windowManager.setSize(Size(800, 600));
          windowManager.setAlignment(Alignment.topRight, animate: true);
          setState(() {
            clipboardAnswer = answer.choices.first.text;
          });
        });
  }*/
}
