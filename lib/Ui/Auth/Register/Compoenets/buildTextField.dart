import 'package:flutter/material.dart';
import 'package:untitled6/Ui/Auth/Register/Compoenets/text.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ColorScheme colorScheme;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.colorScheme,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(
          label: label,
          fontSize: 16,
          color: colorScheme.surface.withOpacity(0.4),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
