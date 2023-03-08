import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:record/record.dart';

import 'package:sizer/sizer.dart';
import 'package:soundscribe/src/screen/chat/ChatScreen.dart';
import 'package:soundscribe/src/screen/whisper/WhisperScreen.dart';
import 'package:soundscribe/src/services/OpenAiServices.dart';
import 'package:soundscribe/src/utils/audio_recorder.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();
  final record = Record();
  static const methodChannel = MethodChannel('soundscribe.suy/methods');
  static const intentsChannel = EventChannel('soundscribe.suy/intents/events');
  static const testMethodChannel = MethodChannel("soundscribe.suy/methodTest");

  String batteryLevel = 'Waiting...';
  String intentsResult = 'no-result';
  String clipboardText = "";
  String clipboardAnswer = "";

  @override
  void initState() {
    super.initState();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              /*  CupertinoButton(
                  child: Text('1'),
                  onPressed: () async {},
                ),*/
                CupertinoButton(
                  child: Text('Battery Level'),
                  onPressed: getBatteryLevel,
                ),
                Text('HOMEPAGE'),
                Text(batteryLevel),
                /*      CupertinoButton(
                    child: Text('clipboard'),
                    onPressed: () async {
                      var data = await getClipboardData();
                      setState(() {
                        clipboardText = data.toString();
                      });
                    }),*/
                Text(clipboardText),
                _voiceRecorder(),
                Text(clipboardAnswer),
                CupertinoButton(
                    child: Text('intent test'), onPressed: getAppIntents),
                Text(intentsResult),
                /*  CupertinoButton(
                    child: Text('noono'),
                    onPressed: () {
                      testMethodChannel
                          .setMethodCallHandler((methodCall) async {
                        debugPrint(
                            "CAUGHT METHOD WITH HANDLER: ${methodCall.method}"); // Never comes here
                        switch (methodCall.method) {
                          case "onFinish":
                    
                            debugPrint("onFinish"); // Never comes here
                            return;
                          default:
                            throw MissingPluginException(
                                'Not Implemented'); // Never comes here
                        }
                      });
                    }),*/
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

        setState(() {
          clipboardAnswer = answer.choices.first.text;
        });
      },
    );
  }
}
