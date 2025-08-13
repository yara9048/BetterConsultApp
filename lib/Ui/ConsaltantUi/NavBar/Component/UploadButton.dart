import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String type;
  final VoidCallback onPressed;
  final ColorScheme colorScheme;

  const UploadButton({
    super.key,
    required this.icon,
    required this.label,
    required this.type,
    required this.onPressed,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'NotoSerifGeorgian',
          ),
        ),
      ),
    );
  }
}
