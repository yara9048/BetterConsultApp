import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart'; // for basename()
import 'package:provider/provider.dart';
import '../../../../Models/Home/Consultant/UploadingVideoVoiceModel.dart';
import '../../../../Providers/Home/Consultant/Segmentation.dart';
import '../../../../Providers/Home/Consultant/TextCheckQuality.dart';
import '../../../../Providers/Home/Consultant/VideoAndVoiceUploading.dart';
import '../../../../generated/l10n.dart';
import '../../../Auth/Register/Compoenets/text.dart';

class ConsultationInputWidget2 extends StatefulWidget {
  final int id;
  final String? selectedOption;
  final List<String> uploadedFiles;
  final Function(String) onTextChanged;
  final Function(String type) onFilePick;
  final VideoAndVoiceUploading videoProvider;
  final Segmentation segmentationProvider;
  final ColorScheme colorScheme;

  const ConsultationInputWidget2({
    super.key,
    required this.id,
    required this.selectedOption,
    required this.uploadedFiles,
    required this.onTextChanged,
    required this.onFilePick,
    required this.videoProvider,
    required this.segmentationProvider,
    required this.colorScheme,
  });

  @override
  State<ConsultationInputWidget2> createState() =>
      _ConsultationInputWidgetState();
}

class _ConsultationInputWidgetState extends State<ConsultationInputWidget2> {
  int? qualityCheckId;
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  Future<void> _uploadFile(BuildContext context) async {
    if (widget.uploadedFiles.isEmpty) return;

    final file = File(widget.uploadedFiles.first);
    final isVideo = widget.selectedOption == S.of(context).video;

    final provider =
    Provider.of<VideoAndVoiceUploading>(context, listen: false);

    await provider.videoAndVoiceUploading(file, isVideo: isVideo);

    if (provider.isSuccess && provider.lastResponseData != null) {
      final model =
      UploadingVideoVoiceModel.fromJson(provider.lastResponseData!);
      setState(() {
        qualityCheckId = model.qualityCheckId;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${isVideo ? 'Video' : 'Voice'} uploaded successfully!")),
      );
    } else if (provider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedOption == null) return const SizedBox();

    final isVideo = widget.selectedOption == S.of(context).video;
    final isVoice = widget.selectedOption == S.of(context).voice;
    final isText = widget.selectedOption == S.of(context).text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================= TEXT MODE =================
        if (isText)
          Column(
            children: [
              TextField(
                controller: _questionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your consultation qusetion",
                  hintStyle: TextStyle(color: widget.colorScheme.primary,  fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSerifGeorgian',), // primary color hint
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: widget.colorScheme.primary, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: widget.colorScheme.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _answerController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your consultation answer",
                  hintStyle: TextStyle(color: widget.colorScheme.primary,  fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSerifGeorgian', ), // primary color hint
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: widget.colorScheme.primary, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: widget.colorScheme.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Consumer<TextCheckQuality>(
                builder: (context, provider, child) => SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: provider.isLoading
                        ? null
                        : () {
                      provider.textCheckQuality(
                        _questionController.text,
                        _answerController.text,
                      );
                    },
                    child: provider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : text( label :S.of(context).confirm,fontSize: 16,color: Colors.white,),
                  ),
                ),
              ),
            ],
          ),

        // ================= VIDEO / VOICE MODE =================
        if (isVideo || isVoice)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Button with Gradient & Shadow
              if (true)
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.colorScheme.primary.withOpacity(0.85),
                        widget.colorScheme.primary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    icon: Icon(isVideo ? Icons.videocam : Icons.mic, color: Colors.white, size: 22),
                    label: text(
                      label: isVideo ? S.of(context).uploadVideo : S.of(context).uploadVoice,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      widget.onFilePick(isVideo ? S.of(context).video : S.of(context).voice);
                    },
                  ),
                ),
              const SizedBox(height: 12),

              // Uploaded File Card
              if (widget.uploadedFiles.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: widget.colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(4, 4),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        offset: Offset(-4, -4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    title: text(
                      label: basename(widget.uploadedFiles.first),
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.delete, color: widget.colorScheme.onSurface),
                        onPressed: () => setState(() => widget.uploadedFiles.clear()),
                      ),
                    ),
                  ),
                ),
              if (widget.uploadedFiles.isNotEmpty) const SizedBox(height: 12),

              // Upload to Server Button
              if (widget.uploadedFiles.isNotEmpty)
                Consumer<VideoAndVoiceUploading>(
                  builder: (context, provider, child) => Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.colorScheme.secondary.withOpacity(0.85),
                          widget.colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: provider.isLoading ? null : () => _uploadFile(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: provider.isLoading
                          ? Center(child: CircularProgressIndicator(color: Colors.white))
                          : text(
                        label: "Upload to Server",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              if (widget.uploadedFiles.isNotEmpty) const SizedBox(height: 12),

              // Segmentation Button
              if (qualityCheckId != null)
                Consumer<Segmentation>(
                  builder: (context, provider, child) => Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.colorScheme.primary.withOpacity(0.85),
                          widget.colorScheme.primary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: provider.isLoading ? null : () => provider.runSegmentation(qualityCheckId!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: provider.isLoading
                          ? Center(child: CircularProgressIndicator(color: Colors.white))
                          : text(
                        label: "Run Segmentation",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
            ],
          )

      ],
    );
  }
}
