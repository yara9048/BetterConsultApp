import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? Theme.of(context).colorScheme.primary.withOpacity(0.6): Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isUser ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
              fontSize: 15,
              fontFamily: 'NotoSerifGeorgian',
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
