import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Providers/Home/User/Others/ChatProvider.dart';
import '../../../generated/l10n.dart';
import '../Components/ChatBubble.dart';

class ChatPage extends StatefulWidget {
  final int consultantId;

  const ChatPage({Key? key, required this.consultantId}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late bool chatted = false;
  bool isArabic() => Intl.getCurrentLocale() == 'ar';

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage(ChatProvider provider, String text) async {
    if (text.trim().isEmpty) return;
    await provider.chat(widget.consultantId.toString(), text);
    _controller.clear();
    chatted = true;
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    await prefs.setBool('chatted_${widget.consultantId}_$id', chatted);
    _scrollToBottom();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(),
      child: Consumer<ChatProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xfff5f7fa),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: isArabic() ? 0 : 50.0,
                    left: isArabic() ? 50 : 0,
                  ),
                  child: Text(
                    S.of(context).chatWithConsultant,
                    style: const TextStyle(
                      fontFamily: 'NotoSerifGeorgian',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: provider.isLoading && provider.chats.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    controller: _scrollController,
                      itemCount: provider.chats.length,
                      itemBuilder: (context, index) {
                        final chat = provider.chats[index];
                        final userMessage = chat.userMessage;
                        final consultantMessage = chat.consultantMessage;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (userMessage != null)
                              ChatBubble(text: userMessage.text, isUser: true),
                            if (consultantMessage != null)
                              ChatBubble(text: consultantMessage.text, isUser: false),
                          ],
                        );
                      }

                  ),
                ),
                if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                _buildInputArea(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea(ChatProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _sendMessage(provider, _controller.text),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontFamily: 'NotoSerifGeorgian',
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: S.of(context).chatHint,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontFamily: 'NotoSerifGeorgian',
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 22),
              onPressed: () => _sendMessage(provider, _controller.text),
            ),
          ),
        ],
      ),
    );
  }
}
