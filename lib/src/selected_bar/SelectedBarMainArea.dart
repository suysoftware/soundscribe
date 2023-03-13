import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class SelectedBarMainArea extends StatefulWidget {
  const SelectedBarMainArea({super.key});

  @override
  State<SelectedBarMainArea> createState() => _SelectedBarMainAreaState();
}

class _SelectedBarMainAreaState extends State<SelectedBarMainArea> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
 height: 50,
        width: 200,
       decoration: BoxDecoration(
        color: CupertinoColors.activeBlue
       ),
      ),
    );
  }
}
