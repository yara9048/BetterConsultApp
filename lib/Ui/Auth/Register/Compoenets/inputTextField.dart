import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/Ui/Auth/Register/Compoenets/text.dart';

class InputTextField extends StatefulWidget {
  final String label;
  final String label1;
  final TextEditingController controller;

  const InputTextField({
    Key? key,
    required this.label,
    required this.label1,
    required this.controller,
  }) : super(key: key);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(label: widget.label, fontSize: 16, color: Theme.of(
          context,
        ).colorScheme.surface.withOpacity(0.4)),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          style: TextStyle(color: colorScheme.surface.withOpacity(0.4)),
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surface.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2.0,
              ),
            ),
            hintText: widget.label1,
            hintStyle: TextStyle(
              color: colorScheme.primary,
              fontSize: 15,
              fontFamily: 'NotoSerifGeorgian',
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
