import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Models/Home/User/NavBar/ChatHistoryModel.dart';
import 'package:untitled6/Providers/Home/User/NavBarProviders/ChatHistoryProvider.dart';
import 'package:untitled6/Providers/Home/User/NavBarProviders/DeleteChatProvider.dart';
import '../../../generated/l10n.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Components/ChatHistoryCard.dart';
import '../Pages/ChatHistory.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatHistoryProvider>(context, listen: false).getChatsHistory();
    });
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          S.of(context).chatHistory,
          style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ChatHistoryProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.errorMessage != null) {
              return Center(
                child: Text(
                  provider.errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                )
              );
            } else if (provider.chats.isEmpty) {
              return Center(
                child: Text(
                  'History is empty',
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            } else {
              return  ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: provider.chats.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final chat = provider.chats[index];
                  return ChatHistoryCard(
                    name: 'Dr. Amira Khaled',
                    specializing: 'Nutritionist',
                    content:chat.title,
                    timestamp: formatDate(chat.createdAt.toString()),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (Context){return ChatHistoryScreen(consultantId: chat.consultant.id,);}));
                    },
                      onDelete: () async {
                        final deleteProvider = Provider.of<DeleteChatProvider>(context, listen: false);
                        final historyProvider = Provider.of<ChatHistoryProvider>(context, listen: false);
                        await deleteProvider.deleteChat(chat.id);
                        if (deleteProvider.isVerified) {
                          historyProvider.getChatsHistory();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: text(
                                label: 'Removed from History!',
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                            ),
                          );
                        }
                      }
                  );
                },

                  );}})
    );
  }
  String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    return "${dateTime.year}\\${dateTime.month}\\${dateTime.day}";
  }
}