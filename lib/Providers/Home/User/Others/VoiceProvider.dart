import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import 'ChatProvider.dart';
import 'package:provider/provider.dart';

import 'VTTProvider.dart';

class VoiceProvider extends ChangeNotifier {
  final _record = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  String? recordedFilePath;
  bool isRecording = false;

  /// Start recording
  Future<void> startRecording() async {
    if (await _record.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

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
    }
  }

  /// Stop recording and send to backend for transcription
  Future<void> stopRecording(
      VttProvider vttProvider, TextEditingController controller, BuildContext context, String consultantId) async {
    final path = await _record.stop();
    isRecording = false;
    notifyListeners();

    if (path != null) {
      recordedFilePath = path;
      final file = File(recordedFilePath!);

      // Send file to backend for transcription
      if (vttProvider != null) {
        await vttProvider.Vtt(file: file);

        if (vttProvider.voiceModel != null) {
          controller.text = vttProvider.voiceModel!.transcript;

          // Auto-send after transcription
          if (controller.text.trim().isNotEmpty) {
            final chatProvider =
            Provider.of<ChatProvider>(context, listen: false);
            await chatProvider.chat(consultantId, controller.text.trim());
            controller.clear();
          }
        }
      }
    }
  }

  Future<void> playAudio(String path) async {
    try {
      await _player.setFilePath(path);
      _player.play();
    } catch (e) {
      debugPrint('Playback error: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
