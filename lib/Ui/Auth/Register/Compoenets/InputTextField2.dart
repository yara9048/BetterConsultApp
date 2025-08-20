import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import 'text.dart';

class InputTextField2 extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const InputTextField2({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  _InputTextField2State createState() => _InputTextField2State();
}

class _InputTextField2State extends State<InputTextField2> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(
          label: widget.label,
          fontSize: 14,
          color: colorScheme.surface.withOpacity(0.4),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          validator: widget.validator,
          style: TextStyle(color: colorScheme.surface.withOpacity(0.4)),
          decoration: InputDecoration(
            prefixIcon: widget.icon != null ? Icon(widget.icon, color: colorScheme.primary) : null,
            filled: true,
            counterText: "",
            fillColor: colorScheme.surface.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
            ),
            hintText: "${S.of(context).enter} ${widget.label.toLowerCase()}" ,
            hintStyle: TextStyle(
              color: colorScheme.primary,
              fontSize: 14,
              fontFamily: 'NotoSerifGeorgian',
            ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
