import 'package:flutter/material.dart';
import 'text.dart';

class SectionTitle extends StatefulWidget {
  final String label;

  const SectionTitle({Key? key, required this.label}) : super(key: key);

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: text(
        label: widget.label,
        fontSize: 16,
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
      ),
    );
  }
}
