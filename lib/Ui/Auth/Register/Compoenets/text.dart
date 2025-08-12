import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class text extends StatefulWidget {
  final String label;
  final double fontSize;
  final Color color;

  const text({
    Key? key,
    required this.label,
    required this.fontSize,
    required this.color,
  }) : super(key: key);

  @override
  _textState createState() => _textState();
}

class _textState extends State<text> {
  @override
  Widget build(BuildContext context) {

    return Text(
      widget.label,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'NotoSerifGeorgian',
      ),
    );
  }
}
