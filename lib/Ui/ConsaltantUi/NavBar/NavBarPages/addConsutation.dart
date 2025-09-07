import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Providers/Home/Consultant/Segmentation.dart';
import '../../../../Providers/Home/Consultant/VideoAndVoiceUploading.dart';
import '../../../../generated/l10n.dart';
import '../../../Auth/Register/Compoenets/text.dart';
import '../Component/InputCard.dart';
import '../Component/OptionCard.dart';


class AddConsultation extends StatefulWidget {
  const AddConsultation({super.key});

  @override
  State<AddConsultation> createState() => _AddConsultationState();
}

class _AddConsultationState extends State<AddConsultation> {
  String? selectedOption;
  List<String> uploadedFiles = [];
  String? consultationText;
  int? qualityCheckId;

  void _selectOption(String option) {
    setState(() {
      selectedOption = option;
      uploadedFiles.clear();
      consultationText = null;
      qualityCheckId = null;
    });
  }

  Future<void> pickFile(String type) async {
    FileType fileType = FileType.custom;
    if (type == S.of(context).video) fileType = FileType.video;
    if (type == S.of(context).voice) fileType = FileType.audio;

    FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType);

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      String extension = path.split('.').last.toLowerCase();

      bool isValid = false;
      if (type == S.of(context).video) isValid = ['mp4', 'mov', 'avi', 'mkv'].contains(extension);
      if (type == S.of(context).voice) isValid = ['mp3', 'wav', 'aac', 'm4a'].contains(extension);

      if (!isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: text(
              label: S.of(context).uploadValidationInvalid + " " + type,
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        return;
      }

      setState(() {
        uploadedFiles.clear();
        uploadedFiles.add(path);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: text(
            label: "${type[0].toUpperCase() + type.substring(1)} ${S.of(context).uploadValidationSuccess}",
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: text(
            label: S.of(context).uploadValidationNoneSelected,
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          S.of(context).addConsultant,
          style: TextStyle(fontFamily: 'NotoSerifGeorgian', fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
            child: Center(
              child: Text(
                S.of(context).addConsultant1,
                style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'NotoSerifGeorgian'),
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  ConsultationOptionCard(
                    label: S.of(context).video,
                    icon: Icons.videocam,
                    value: S.of(context).video,
                    isSelected: selectedOption == S.of(context).video,
                    onTap: () => _selectOption(S.of(context).video),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(width: 12),
                  ConsultationOptionCard(
                    label: S.of(context).voice,
                    icon: Icons.mic,
                    value: S.of(context).voice,
                    isSelected: selectedOption == S.of(context).voice,
                    onTap: () => _selectOption(S.of(context).voice),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(width: 12),
                  ConsultationOptionCard(
                    label: S.of(context).text,
                    icon: Icons.text_snippet,
                    value: S.of(context).text,
                    isSelected: selectedOption == S.of(context).text,
                    onTap: () => _selectOption(S.of(context).text),
                    colorScheme: colorScheme,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ConsultationInputWidget(
                selectedOption: selectedOption,
                uploadedFiles: uploadedFiles,
                onTextChanged: (text) => setState(() => consultationText = text),
                onFilePick: pickFile,
                videoProvider: context.read<VideoAndVoiceUploading>(),
                segmentationProvider: context.read<Segmentation>(),
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
