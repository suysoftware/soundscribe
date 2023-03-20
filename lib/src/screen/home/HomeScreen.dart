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

class _HomeScreenState extends State<HomeScreen>  {







  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGrey,
        child: Container(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

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

             

            ],
          ),
        ));
  }




/* Widget _voiceRecorder() {
    return GestureDetector(
      child: Icon(CupertinoIcons.mic),
      onLongPress: () async {
        audioPath = (await AudioRecorder.audioRecordStart(record))!;
      },
      onLongPressEnd: (s) async {
        await AudioRecorder.audioRecordStop(record);

       // var data = await getClipboardData();

        var result = await OpenAiServices.audioSender(false, audioPath);

       // var answer = await OpenAiServices.openAiQuestionRequest(
       //     '"' + data.toString() + '"' + result);

        windowManager.setSize(Size(800, 600));
        windowManager.setAlignment(Alignment.topRight, animate: true);
        setState(() {
       //   clipboardAnswer = answer.choices.first.text;
        });
      },
    );
  }*/



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
