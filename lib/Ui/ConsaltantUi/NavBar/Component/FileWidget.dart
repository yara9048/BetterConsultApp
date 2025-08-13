import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileDisplayWidget extends StatelessWidget {
  final List<String> uploadedFiles;
  final Function(String) onDelete;
  final ColorScheme colorScheme;

  const FileDisplayWidget({
    super.key,
    required this.uploadedFiles,
    required this.onDelete,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    if (uploadedFiles.isEmpty) return const SizedBox();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...uploadedFiles.map((file) {
          String fileName = file.split('/').last;
          return Chip(
            label: Text(
              fileName,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'NotoSerifGeorgian',
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            backgroundColor: colorScheme.primary,
            deleteIcon: Icon(
              Icons.close,
              color: colorScheme.onSurface,
            ),
            onDeleted: () => onDelete(file),
          );
        }).toList(),
      ],
    );
  }
}
