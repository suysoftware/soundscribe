import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorder {
  static Future<String?> audioRecordStart(Record record) async {
// Check and request permission
    print('basladi');
    if (await record.hasPermission()) {
      // Start recording

      Directory directory = await getApplicationSupportDirectory();
      print(directory.path);
      String filepath = directory.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.m4a';

      try {
        await record.start(
          path: filepath,
          samplingRate: 44100,
          encoder: AudioEncoder.aacLc, // by default
          bitRate: 128000, // by default
        );

        return filepath;
      } catch (e) {
        
        print(e);
      }
    }

// Get the state of the recorder
  }

  static Future<void> audioRecordStop(Record record) async {
    print('bitir');
    bool isRecording = await record.isRecording();
    if (isRecording) {
      print('yesrecording');
      await record.stop();
    }
  }
}
