import 'package:flutter/material.dart';

import '../../../Auth/Register/Compoenets/text.dart';
import 'FileWidget.dart';
import 'UploadButton.dart';

class ConsultationInputWidget extends StatelessWidget {
  final String? selectedOption;
  final List<String> uploadedFiles;
  final Function(String) onTextChanged;
  final Function(String) onFileUpload;
  final Function(String) onFileDelete;
  final ColorScheme colorScheme;
  final String? consultationText;

  const ConsultationInputWidget({
    super.key,
    required this.selectedOption,
    required this.uploadedFiles,
    required this.onTextChanged,
    required this.onFileUpload,
    required this.onFileDelete,
    required this.colorScheme,
    required this.consultationText
  });

  @override
  Widget build(BuildContext context) {
    if (selectedOption == null) return const SizedBox();

    return Column(
      children: [
        Card(
          color: colorScheme.onSurface,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedOption == 'video'
                        ? "Upload your video"
                        : selectedOption == 'voice'
                        ? "Upload your voice recording"
                        : "Write your consultation text",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'NotoSerifGeorgian',
                      fontWeight: FontWeight.bold,
                      color: colorScheme.surface.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (selectedOption == 'video')
                    UploadButton(
                      icon: Icons.videocam,
                      label: "Upload Video",
                      type: "video",
                      onPressed: () => onFileUpload("video"),
                      colorScheme: colorScheme,
                    )
                  else if (selectedOption == 'voice')
                    UploadButton(
                      icon: Icons.mic,
                      label: "Upload Audio",
                      type: "voice",
                      onPressed: () => onFileUpload("voice"),
                      colorScheme: colorScheme,
                    )
                  else
                    TextField(
                      maxLines: 5,
                      onChanged: onTextChanged,
                      style: TextStyle(
                        color: colorScheme.surface.withOpacity(0.4),
                        fontSize: 14,
                        fontFamily: 'NotoSerifGeorgian',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Type your consultation here...",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: colorScheme.primary,
                          fontFamily: 'NotoSerifGeorgian',
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (selectedOption != 'text')
                    FileDisplayWidget(
                      uploadedFiles: uploadedFiles,
                      onDelete: onFileDelete,
                      colorScheme: colorScheme,
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.black45,
              elevation: 5,
            ),
            onPressed: () {
              if (selectedOption == 'text' &&
                  (consultationText == null || consultationText!.isEmpty)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: text(
                      label: "Please enter your text consultation",
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                    backgroundColor: colorScheme.secondary,
                  ),
                );
                return;
              }
              if ((selectedOption == 'video' || selectedOption == 'voice') &&
                  uploadedFiles.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: text(
                      label: 'Please upload a ${selectedOption!} file.',
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                    backgroundColor: colorScheme.secondary,
                  ),
                );
                return;
              }

              print("Confirmed! Option: $selectedOption");
              if (selectedOption == 'text') {
                print("Text: $consultationText");
              } else {
                print("Files: $uploadedFiles");
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: text(
                    label: "Consultation submitted successfully!",
                    fontSize: 14,
                    color: colorScheme.onSurface,
                  ),
                  backgroundColor: colorScheme.secondary,
                ),
              );
            },
            child: Text(
              "Confirm",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                fontFamily: 'NotoSerifGeorgian',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
