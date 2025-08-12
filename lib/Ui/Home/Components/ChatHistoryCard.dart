import 'package:flutter/material.dart';

class ChatHistoryCard extends StatelessWidget {
  final String name;
  final String specializing;
  final String content;
  final String timestamp;
  final VoidCallback onTap;

  const ChatHistoryCard({
    super.key,
    required this.name,
    required this.specializing,
    required this.content,
    required this.timestamp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSerifGeorgian',
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                Text(
                  timestamp,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              specializing,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontStyle: FontStyle.italic,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Icon(Icons.chevron_right,color: Theme.of(context).colorScheme.onPrimary,)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
