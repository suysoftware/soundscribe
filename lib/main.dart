import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';
import 'package:soundscribe/src/screen/home/HomeScreen.dart';
import 'package:soundscribe/src/screen/whisper/WhisperScreen.dart';

import 'src/screen/chat/ChatScreen.dart';

Future<void> main() async {
  await init();
  
  runApp(const SoundscribeApp());
}

Future<void>init ()async{
  await dotenv.load(fileName: ".env");
    
}

class SoundscribeApp extends StatelessWidget {
  const SoundscribeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return _cupertinoApp();
    }));
  }
}

class _cupertinoApp extends StatefulWidget {
  const _cupertinoApp({super.key});

  @override
  State<_cupertinoApp> createState() => _cupertinoAppState();
}

class _cupertinoAppState extends State<_cupertinoApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: {
        "/": (BuildContext context) => const HomeScreen(),
        "/ChatScreen": (BuildContext context) => const ChatScreen(),
        "/WhisperScreen": (BuildContext context) => const WhisperScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
