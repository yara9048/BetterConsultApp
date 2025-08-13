import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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

  void _selectOption(String option) {
    setState(() {
      selectedOption = option;
      uploadedFiles.clear();
      consultationText = null;
    });
  }

  Future<void> pickFile(String type) async {
    FileType fileType = FileType.custom;

    if (type == "video") {
      fileType = FileType.video;
    } else if (type == "voice") {
      fileType = FileType.audio;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
    );

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      String extension = path.split('.').last.toLowerCase();

      bool isValid = false;
      if (type == "video") {
        isValid = ['mp4', 'mov', 'avi', 'mkv'].contains(extension);
      } else if (type == "voice") {
        isValid = ['mp3', 'wav', 'aac', 'm4a'].contains(extension);
      }

      if (!isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: text(
              label: "Invalid file type. Please upload a $type file.",
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        return;
      }

      setState(() {
        uploadedFiles.add(path);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: text(
            label:
            "${type[0].toUpperCase()}${type.substring(1)} uploaded successfully!",
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
            label: "No file selected.",
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
        title: const Text(
          "Add a Consultation",
          style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontWeight: FontWeight.bold,
          ),
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
                "Choose the consultation type then uploaded it ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'NotoSerifGeorgian',
                ),
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
                    label: "Video",
                    icon: Icons.videocam,
                    value: "video",
                    isSelected: selectedOption == "video",
                    onTap: () => _selectOption("video"),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(width: 12),
                  ConsultationOptionCard(
                    label: "Voice",
                    icon: Icons.mic,
                    value: "voice",
                    isSelected: selectedOption == "voice",
                    onTap: () => _selectOption("voice"),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(width: 12),
                  ConsultationOptionCard(
                    label: "Text",
                    icon: Icons.text_snippet,
                    value: "text",
                    isSelected: selectedOption == "text",
                    onTap: () => _selectOption("text"),
                    colorScheme: colorScheme,
                  ),
                ],
              ),
              ConsultationInputWidget(
                selectedOption: selectedOption,
                uploadedFiles: uploadedFiles,
                onTextChanged: (val) => setState(() => consultationText = val),
                onFileUpload: pickFile,
                onFileDelete: (file) => setState(() => uploadedFiles.remove(file)),
                colorScheme: colorScheme,
                consultationText: consultationText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}