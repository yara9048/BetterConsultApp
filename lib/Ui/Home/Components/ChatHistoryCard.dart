import 'package:flutter/material.dart';

class ChatHistoryCard extends StatelessWidget {
  final String name;
  final String specializing;
  final String content;
  final String timestamp;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ChatHistoryCard({
    super.key,
    required this.name,
    required this.specializing,
    required this.content,
    required this.timestamp,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
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

              children: [
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSerifGeorgian',
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(width: 30,),

                Text(
                  timestamp,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: theme.colorScheme.primary,size: 20,),
                  onPressed: onDelete,
                  tooltip: "Delete",
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
              children: [
                Expanded(
                  child: Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onPrimary,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
