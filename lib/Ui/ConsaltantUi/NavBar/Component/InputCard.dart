import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Models/Home/Consultant/quaityDataModel.dart';
import '../../../../Providers/Home/Consultant/CheckQuaityProvider.dart';
import '../../../../generated/l10n.dart';
import '../../../Auth/Register/Compoenets/text.dart';
import 'FileWidget.dart';
import 'UploadButton.dart';

class ConsultationInputWidget extends StatefulWidget {
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
    required this.consultationText,
  });

  @override
  State<ConsultationInputWidget> createState() =>
      _ConsultationInputWidgetState();
}

class _ConsultationInputWidgetState extends State<ConsultationInputWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.selectedOption == null) return const SizedBox();

    return Consumer<CheckQuaityProvider>(
      builder: (context, provider, child) {
        final isVideo = widget.selectedOption == S.of(context).video;
        final isVoice = widget.selectedOption == S.of(context).voice;

        final isGoodQuality = provider.isGoodQuality;

        final canConfirm = !isVideo || (isVideo && isGoodQuality);

        return Column(
          children: [
            Card(
              color: widget.colorScheme.onSurface,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isVideo
                            ? S.of(context).uploadYourVideo
                            : isVoice
                            ? S.of(context).uploadYourVoice
                            : S.of(context).uploadYourTextHint,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NotoSerifGeorgian',
                          fontWeight: FontWeight.bold,
                          color: widget.colorScheme.surface.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Upload buttons / text input
                      if (isVideo)
                        UploadButton(
                          icon: Icons.videocam,
                          label: S.of(context).uploadVideo,
                          type: "video",
                          onPressed: () {
                            print(widget.selectedOption);
                            print('--------------------------');

                            print(isGoodQuality);
                            print('======================');

                            print(canConfirm);
                            print('-----------------------');

                            print(isVideo);
                            print('--------------------');

                            widget.onFileUpload(S.of(context).video);},
                          colorScheme: widget.colorScheme,
                        )
                      else if (isVoice)
                        UploadButton(
                          icon: Icons.mic,
                          label: S.of(context).uploadVoice,
                          type: "voice",
                          onPressed: () =>
                              widget.onFileUpload(S.of(context).voice),
                          colorScheme: widget.colorScheme,
                        )
                      else
                        TextField(
                          maxLines: 5,
                          onChanged: widget.onTextChanged,
                          style: TextStyle(
                            color: widget.colorScheme.surface.withOpacity(0.4),
                            fontSize: 14,
                            fontFamily: 'NotoSerifGeorgian',
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: S.of(context).uploadYourTextHint,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: widget.colorScheme.primary,
                              fontFamily: 'NotoSerifGeorgian',
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: widget.colorScheme.primary,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: widget.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      if (isVideo && widget.uploadedFiles.isNotEmpty)
                        FileDisplayWidget(
                          uploadedFiles: widget.uploadedFiles,
                          onDelete: widget.onFileDelete,
                          colorScheme: widget.colorScheme,
                        ),

                      if (isVideo && widget.uploadedFiles.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.colorScheme.onSurface,
                                foregroundColor: widget.colorScheme.primary,
                                side: BorderSide(
                                  color: widget.colorScheme.primary,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: provider.isLoading
                                  ? null
                                  : () async {
                                print(widget.selectedOption);
                                print('--------------------------');

                                print(isGoodQuality);
                                print('======================');

                                print(canConfirm);
                                print('-----------------------');

                                print(isVideo);
                                print('--------------------');

                                final provider = context
                                    .read<CheckQuaityProvider>();
                                final filePath =
                                    widget.uploadedFiles.first;

                                await provider
                                    .checkQuality(File(filePath));

                                if (provider.data.isNotEmpty &&
                                    provider.data.first.status == "ok") {
                                  provider.setGoodQuality(provider.data.isNotEmpty &&
                                      provider.data.first.status == "ok");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      children: [
                                        text(
                                          label:
                                          "Video has good quality",
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 40.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              showResultsDialog(context,
                                                  provider
                                                      .data.first.results);
                                            },
                                            child: text(
                                              label: "See details?",
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Please upload a new video",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ));
                                }
                              },
                              child: provider.isLoading
                                  ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: widget.colorScheme.primary,
                                ),
                              )
                                  : Text(
                                'Check Quality',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
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
                  backgroundColor: widget.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.black45,
                  elevation: 5,
                ),
                onPressed: canConfirm
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: text(
                        label: S.of(context).consultationDone,
                        fontSize: 14,
                        color: widget.colorScheme.onSurface,
                      ),
                      backgroundColor:
                      widget.colorScheme.secondary,
                    ),
                  );
                }
                    : null,
                child: Text(
                  S.of(context).confirm,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.colorScheme.onSurface,
                    fontFamily: 'NotoSerifGeorgian',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showResultsDialog(BuildContext context, Results results) {
    final theme = Theme.of(context);

    Widget buildSection(String title, List<Widget> children) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            ...children,
          ],
        ),
      );
    }

    Widget buildDetail(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: TextStyle(
                  color: theme.colorScheme.primary.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSection("🎵 Audio", [
                  buildDetail("Loudness",
                      "${results.audioLoudness.status} (${results.audioLoudness.valueDbfs} dBFS)"),
                  buildDetail("SNR", "${results.snr.snrDb} dB"),
                  buildDetail("Issues", results.audioIssues.status),
                  buildDetail("Silence", results.silence.status),
                ]),
                buildSection("🎥 Video", [
                  buildDetail("Black Screen", results.blackScreen.status),
                  buildDetail("Blurriness", results.blurriness.status),
                  buildDetail("Resolution",
                      "${results.resolution.status} (${results.resolution.resolution})"),
                  buildDetail("Frame Rate",
                      "${results.frameRate.status} (${results.frameRate.fps} fps)"),
                ]),
                buildSection("👤 System", [
                  buildDetail("Face Consistency",
                      results.faceConsistency.error),
                ]),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                "OK",
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
