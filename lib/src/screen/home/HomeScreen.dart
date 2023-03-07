import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
import 'package:macos_ui/macos_ui.dart';

import 'package:sizer/sizer.dart';
import 'package:soundscribe/src/screen/chat/ChatScreen.dart';
import 'package:soundscribe/src/screen/whisper/WhisperScreen.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();

  final channel = MethodChannel('mcn');
  static const batterChannel = MethodChannel('soundscribe.suy/battery');
  String batteryLevel = 'Waiting...';
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
                CupertinoButton(
                  child: Text('1'),
                  onPressed: () async {},
                ),
                CupertinoButton(
                  child: Text('2'),
                  onPressed: getBatteryLevel,
                ),
                Text('HOMEPAGE'),
                Text(batteryLevel)
              ],
            ),
          )),
    );
  }

  Future getBatteryLevel() async {
    final arguments = {'name': 'Sarah Abs'};
    var newBatterLevel =
        await batterChannel.invokeMethod('getBatteryLevel', arguments);
    setState(() => batteryLevel = '$newBatterLevel%');
  }
}
