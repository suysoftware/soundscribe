import 'package:flutter/cupertino.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:soundscribe/src/accessibility/main_area.dart';
import 'package:soundscribe/src/utils/sidebar_content.dart';
import 'package:soundscribe/src/utils/transparent_sidebar_and_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSidebarOpen = false;
  @override
  Widget build(BuildContext context) {
    return TransparentSidebarAndContent(
      isOpen: _isSidebarOpen,
      width: 280.0,
      sidebarBuilder: () => const TitlebarSafeArea(
        child: SidebarContent(),
      ),
      child: TitlebarSafeArea(
        child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.white,
          navigationBar: CupertinoNavigationBar(
            middle: const Text('macos_window_utils demo'),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.sidebar_left,
              ),
              onPressed: () => setState(() {
                _isSidebarOpen = !_isSidebarOpen;
              }),
            ),
          ),
          child: 
       SafeArea(
              child: MainArea(
                setState: setState,
              ),
            ),
          
         /* Container(
            color: CupertinoColors.white,
            child: Column(
              children: [
                CupertinoButton(
                    child: Text('ChatGPT'),
                    onPressed: () {
                      Navigator.pushNamed(context, "/ChatScreen");
                    }),
                CupertinoButton(
                    child: Text('Whisper'),
                    onPressed: () {
                      Navigator.pushNamed(context, "/WhisperScreen");
                    })
              ],
            ),
          ),*/
        ),
      ),
    );
  }
}
