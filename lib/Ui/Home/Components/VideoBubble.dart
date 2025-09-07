import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoBubble extends StatefulWidget {
  final String relativeVideoPath; // backend relative path
  final String? summary;
  final bool isUser;
  final String baseUrl;

  const VideoBubble({
    super.key,
    required this.relativeVideoPath,
    this.summary,
    required this.isUser,
    required this.baseUrl,
  });

  @override
  State<VideoBubble> createState() => _VideoBubbleState();
}

class _VideoBubbleState extends State<VideoBubble> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final fullUrl = "${widget.baseUrl}${widget.relativeVideoPath}";
      print("🎬 Loading video from URL: $fullUrl");

      // Download video to temporary file
      final dio = Dio();
      final response = await dio.get<List<int>>(
        fullUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_video_${DateTime.now().millisecondsSinceEpoch}.mp4');
      await tempFile.writeAsBytes(response.data!);

      _videoController = VideoPlayerController.file(tempFile)
        ..initialize().then((_) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoController!,
              autoPlay: false,
              looping: false,
            );
            _loading = false;
          });
        }).catchError((e) {
          setState(() {
            _error = "Failed to initialize video: $e";
            _loading = false;
          });
        });
    } catch (e) {
      setState(() {
        _error = "Failed to load video: $e";
        _loading = false;
      });
      print("❌ Video loading error: $e");
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.isUser
              ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
          widget.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: _videoController?.value.isInitialized == true
                  ? _videoController!.value.aspectRatio
                  : 16 / 9,
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(child: Text(_error!))
                  : Chewie(controller: _chewieController!),
            ),
            if (widget.summary != null) ...[
              const SizedBox(height: 8),
              Text(
                widget.summary!,
                style: const TextStyle(
                  fontFamily: 'NotoSerifGeorgian',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
