import 'package:flutter/material.dart';

class ProfileItemRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onEdit;
  final Widget? trailingWidget;

  const ProfileItemRow({
    super.key,
    required this.icon,
    required this.label,
    this.trailingWidget,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.onPrimary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: theme.colorScheme.onPrimary,
              fontFamily: 'NotoSerifGeorgian',
            ),
          ),
        ),
        // show only one icon: either trailingWidget OR default edit
        if (onEdit != null)
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(Icons.edit, size: 20, color: theme.colorScheme.primary),
            onPressed: onEdit,
          ),
      ],
    );

  }
}
