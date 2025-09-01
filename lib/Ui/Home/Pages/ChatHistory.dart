import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Providers/Home/User/Others/ChatHistoryContentProvider.dart';
import 'package:untitled6/Models/Home/User/Others/ChatHistoryContent.dart';

import '../../../generated/l10n.dart';
import '../Components/ChatBubble.dart';

class ChatHistoryScreen extends StatelessWidget {
  final int consultantId;

  const ChatHistoryScreen({super.key, required this.consultantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ChatHistoryContentProvider()
            ..getChatsHistory(consultant_id: consultantId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(
                right: isArabic() ? 0 : 50.0,
                left: isArabic() ? 50 : 0,
              ),
              child: Text(
                S.of(context).history,
                style: const TextStyle(
                  fontFamily: 'NotoSerifGeorgian',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Consumer<ChatHistoryContentProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }

            if (provider.chats.isEmpty) {
              return const Center(child: Text("No messages yet"));
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 20),
              child: ListView.builder(
                reverse: true,
                itemCount: provider.chats.length,
                itemBuilder: (context, index) {
                  final ChatHistoryContentModel chat = provider.chats[index];
                  final bool isUser = chat.sender == "U";

                  return ChatBubble(text: chat.text ?? "", isUser: isUser);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
