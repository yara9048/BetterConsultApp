import 'package:flutter/material.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode; // nullable for last field
  final FocusNode? prevFocusNode; // nullable for first field
  final Color primaryColor;
  final Color fillColor;

  const OtpField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.prevFocusNode,
    required this.primaryColor,
    required this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: primaryColor,
              width: 2.0,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              focusNode.unfocus();
            }
          } else if (value.isEmpty) {
            if (prevFocusNode != null) {
              FocusScope.of(context).requestFocus(prevFocusNode);
            }
          }
        },
      ),
    );
  }
}
