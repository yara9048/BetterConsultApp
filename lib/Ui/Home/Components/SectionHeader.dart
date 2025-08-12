import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String label;

  const SectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
          fontFamily: 'NotoSerifGeorgian'
      ),
    );
  }
}
