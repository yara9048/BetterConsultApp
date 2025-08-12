import 'package:flutter/material.dart';
import '../Components/ChatHistoryCard.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text(
          'Chat History',
          style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ChatHistoryCard(
            name: 'Dr. Amira Khaled',
            specializing: 'Nutritionist',
            content: 'Here goes the content of the chat',
            timestamp: 'Jul 30 • 3:14 PM',
            onTap: () {
              // Navigate to chat screen
            },
          );
        },
      ),
    );
  }
}