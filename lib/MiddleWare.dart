import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soundscribe/MainArea.dart';
import 'package:soundscribe/src/selected_bar/SelectedBarMainArea.dart';
import 'package:window_manager/window_manager.dart';

class MiddleWare extends StatefulWidget {
  @override
  _MiddleWareState createState() => _MiddleWareState();
}

class _MiddleWareState extends State<MiddleWare> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);

    _init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
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
