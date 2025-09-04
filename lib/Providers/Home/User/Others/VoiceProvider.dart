import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class VoiceProvider extends ChangeNotifier {
  final _record = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  String? recordedFilePath;
  bool isRecording = false;

  Future<void> startRecording() async {
    try {
      if (await _record.hasPermission()) {
        final dir = await getApplicationDocumentsDirectory();
        final path =
            '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        debugPrint('Starting recording at path: $path');

        await _record.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: path,
        );

        recordedFilePath = path;
        isRecording = true;
        notifyListeners();

        debugPrint('Recording started: $recordedFilePath');
      } else {
        debugPrint('No microphone permission granted.');
      }
    } catch (e) {
      debugPrint('Recording error: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await _record.stop();
      isRecording = false;

      debugPrint('Recording stopped. Path returned by Record: $path');

      if (path != null) {
        recordedFilePath = path; // File is saved here
        final file = File(path);
        debugPrint('File exists: ${file.existsSync()}');
        debugPrint('File length: ${file.lengthSync()} bytes');
        debugPrint('File path: ${file.path}');

        // Automatically play for testing (optional)
        await playAudio(path);
      } else {
        debugPrint('No file path returned from stop().');
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Stop error: $e');
    }
  }

  /// Play recorded audio
  Future<void> playAudio(String path) async {
    try {
      debugPrint('Playing audio from path: $path');
      await _player.setFilePath(path);
      _player.play();
    } catch (e) {
      debugPrint('Playback error: $e');
    }
  }

  File? getRecordedFile() {
    if (recordedFilePath != null) {
      return File(recordedFilePath!);
    }
    return null;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
