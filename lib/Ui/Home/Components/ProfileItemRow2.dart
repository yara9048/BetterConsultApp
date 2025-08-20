import 'package:flutter/material.dart';

class ProfileItemRow2 extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailingWidget;

  const ProfileItemRow2({
    super.key,
    required this.icon,
    required this.label,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onPrimary, size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: theme.colorScheme.onPrimary,
            fontFamily: 'NotoSerifGeorgian',
          ),
        ),
        const Spacer(), // pushes edit icon to the end
        if (trailingWidget != null) trailingWidget!,
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.edit, color: theme.colorScheme.onPrimary, size: 20)),
      ],
    );
  }
}
