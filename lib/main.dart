import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:soundscribe/MainArea.dart';
import 'package:soundscribe/src/screen/home/HomeScreen.dart';
import 'package:soundscribe/src/screen/whisper/WhisperScreen.dart';
import 'package:soundscribe/MiddleWare.dart';
import 'package:window_manager/window_manager.dart';

import 'src/screen/chat/ChatScreen.dart';

Future<void> main() async {
  await init();

  runApp(const SoundscribeApp());
}

Future<void> init() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
   WindowOptions windowOptions = const WindowOptions(
    alwaysOnTop: true,
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.amber,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
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

class _cupertinoAppState extends State<_cupertinoApp>  {
 

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      home: MiddleWare(),

      /*  routes: {
        "/": (BuildContext context) => const HomeScreen(),
        "/ChatScreen": (BuildContext context) => const ChatScreen(),
        "/WhisperScreen": (BuildContext context) => const WhisperScreen()
      },*/

      debugShowCheckedModeBanner: false,
    );
  }

}
