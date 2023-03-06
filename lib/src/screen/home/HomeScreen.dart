import 'package:flutter/cupertino.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBlue,
        middle: Text('Soundscribe'),
      ),
      child: Container(
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
      ),
    );
  }
}
