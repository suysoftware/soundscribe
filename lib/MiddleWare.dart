import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:record/record.dart';
import 'package:soundscribe/MainArea.dart';
import 'package:soundscribe/src/selected_bar/SelectedBarMainArea.dart';
import 'package:soundscribe/src/utils/audio_recorder.dart';
import 'package:window_manager/window_manager.dart';

import 'src/screen/whisper/WhisperScreen.dart';
import 'src/services/DalleServices.dart';
import 'src/services/DeepLServices.dart';
import 'src/services/OpenAiServices.dart';

class MiddleWare extends StatefulWidget {
  @override
  _MiddleWareState createState() => _MiddleWareState();
}

class _MiddleWareState extends State<MiddleWare>
    with WindowListener, ClipboardListener {
  final record = Record();
  static const methodChannel = MethodChannel('soundscribe.suy/methods');
  static const statusBarMethodChannel =
      MethodChannel('soundscribe.suy/statusBarChannel');
  int count = 0;
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

  channelOperations() {
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
        case "sBar/Rewrite":
          //debugPrint("Click 2 basti"); //

          fastRequester("Bu maile cevap hazırla");

          return;
        case "sBar/startRecord":
          //debugPrint("Click 2 basti"); //

          audioPath = (await AudioRecorder.audioRecordStart(record))!;

          return;
        case "sBar/stopRecord":
          //debugPrint("Click 2 basti"); //
          await AudioRecorder.audioRecordStop(record);
          // var data = await getClipboardData();

          var result = await OpenAiServices.audioSender(false, audioPath);

          var answer = await OpenAiServices.openAiQuestionRequest(
              '"' + clipboardText.toString() + '"' + result);

          setState(() {
            clipboardText = answer.choices.first.text;
          });

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
          print(methodCall.arguments);
          return;
      }
    });
  }

  @override
  void initState() {
    windowManager.addListener(this);
    clipboardWatcher.addListener(this);
    // start watch
    clipboardWatcher.start();
    channelOperations();
    _init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    clipboardWatcher.removeListener(this);
    // stop watch
    clipboardWatcher.stop();
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainArea();
  }

  Future<String?> getClipboardData() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData!.text != null) {
      return clipboardData!.text;
    }
  }

// Clipboard'a veri yazmak için aşağıdaki kodu kullanabilirsiniz
  Future<void> setClipboardData(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
  }

  @override
  void onClipboardChanged() async {
    String? newClipboardData = await getClipboardData();
    clipboardText = newClipboardData!;
  }

  @override
  void onWindowEvent(String eventName) {}

  @override
  void onWindowFocus() {
    // Make sure to call once.
    print("focus");

    setState(() {});
    // do something
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    await windowManager.blur();
    await windowManager.minimize();
    if (_isPreventClose) {
      await windowManager.blur();
      await windowManager.minimize();
      /*   showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Do you want to close Soundscribe?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () async {
                  await windowManager.hide();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );*/
    }
  }

  @override
  void onWindowBlur() {
    // do something
  }

  @override
  void onWindowMaximize() {
    // do something
  }

  @override
  void onWindowUnmaximize() {
    // do something
  }

  @override
  void onWindowMinimize() async {
    // do something
    WindowOptions windowOptions = const WindowOptions(
      alwaysOnTop: true,
      size: Size(800, 600),
      center: true,
      backgroundColor: Colors.amber,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    await windowManager.setSize(
      Size(300, 300),
    );
    await windowManager.setAlignment(Alignment.topRight);
  }

  @override
  void onWindowRestore() {
    // do something
  }

  @override
  void onWindowResize() {
    // do something
  }

  @override
  void onWindowMove() {
    // do something
  }

  @override
  void onWindowEnterFullScreen() {
    // do something
  }

  @override
  void onWindowLeaveFullScreen() {
    // do something
  }
}
