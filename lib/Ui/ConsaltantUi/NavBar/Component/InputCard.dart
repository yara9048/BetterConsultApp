import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
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
                    selectedOption == S.of(context).video
                        ? S.of(context).uploadYourVideo
                        : selectedOption == S.of(context).voice
                        ? S.of(context).uploadYourVoice
                        : S.of(context).uploadYourTextHint,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'NotoSerifGeorgian',
                      fontWeight: FontWeight.bold,
                      color: colorScheme.surface.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (selectedOption == S.of(context).video)
                    UploadButton(
                      icon: Icons.videocam,
                      label: S.of(context).uploadVideo,
                      type: "video",
                      onPressed: () => onFileUpload(S.of(context).video),
                      colorScheme: colorScheme,
                    )
                  else if (selectedOption == S.of(context).voice)
                    UploadButton(
                      icon: Icons.mic,
                      label: S.of(context).uploadVoice,
                      type: "voice",
                      onPressed: () => onFileUpload(S.of(context).voice),
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
                        hintText: S.of(context).uploadYourTextHint,
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
                  if (selectedOption != S.of(context).text)
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
              if (selectedOption == S.of(context).text &&
                  (consultationText == null || consultationText!.isEmpty)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: text(
                      label: S.of(context).uploadYourTextHint,
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                    backgroundColor: colorScheme.secondary,
                  ),
                );
                return;
              }
              if ((selectedOption == S.of(context).video|| selectedOption == S.of(context).voice) &&
                  uploadedFiles.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: text(
                      label: "${S.of(context).pleaseUpload} ${selectedOption!}",
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                    backgroundColor: colorScheme.secondary,
                  ),
                );
                return;
              }

              print(S.of(context).confirmedOption + selectedOption!);
              if (selectedOption == S.of(context).text) {
                print(S.of(context).text + consultationText!);
              } else {
                print(uploadedFiles);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: text(
                    label: S.of(context).consultationDone,
                    fontSize: 14,
                    color: colorScheme.onSurface,
                  ),
                  backgroundColor: colorScheme.secondary,
                ),
              );
            },
            child: Text(
              S.of(context).confirm,
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
