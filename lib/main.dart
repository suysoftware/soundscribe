import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:macos_window_utils/macos/ns_window_delegate.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:macos_window_utils/widgets/titlebar_safe_area.dart';
import 'package:sizer/sizer.dart';
import 'package:soundscribe/src/screen/home/HomeScreen.dart';
import 'package:soundscribe/src/screen/whisper/WhisperScreen.dart';

import 'src/screen/chat/ChatScreen.dart';



class _MyDelegate extends NSWindowDelegate {
  @override
  void windowDidEnterFullScreen() {
    print('The window has entered fullscreen mode.');
    
    super.windowDidEnterFullScreen();
  }
}

final options = NSAppPresentationOptions.from({
  // fullScreen needs to be present as a fullscreen presentation option at all
  // times.
  NSAppPresentationOption.fullScreen,

  // Hide the toolbar automatically in fullscreen mode.
  NSAppPresentationOption.autoHideToolbar,

  // autoHideToolbar must be accompanied by autoHideMenuBar.
  NSAppPresentationOption.autoHideMenuBar,

  // autoHideMenuBar must be accompanied by either autoHideDock or hideDock.
  NSAppPresentationOption.autoHideDock,
});

// Apply the options as fullscreen presentation options.

 final delegate = _MyDelegate();
 final handle = WindowManipulator.addNSWindowDelegate(delegate);
Future<void> main() async {
  await init();

  runApp(const SoundscribeApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManipulator.initialize(enableWindowDelegate: true);
  await dotenv.load(fileName: ".env");
}

class SoundscribeApp extends StatelessWidget  {
  const SoundscribeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return TitlebarSafeArea(
        
        
        child: _cupertinoApp());
    }));
  }
}

class _cupertinoApp extends StatefulWidget {
  const _cupertinoApp({super.key});
  
  @override
  State<_cupertinoApp> createState() => _cupertinoAppState();
}

class _cupertinoAppState extends State<_cupertinoApp> with WidgetsBindingObserver{

Brightness? _brightness;
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.window.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance.window.platformBrightness;
      });
    }
       super.didChangePlatformBrightness();
  }

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
