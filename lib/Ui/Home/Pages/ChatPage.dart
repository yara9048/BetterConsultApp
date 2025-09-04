import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Providers/Home/User/Others/ChatProvider.dart';
import '../../../Providers/Home/User/Others/VoiceProvider.dart';
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

  Future<void> _sendMessage(ChatProvider chatProvider) async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    await chatProvider.chat(widget.consultantId.toString(), text);
    _controller.clear();
    chatted = true;

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    await prefs.setBool('chatted_${widget.consultantId}_$id', chatted);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => VoiceProvider()),
      ],
      child: Consumer2<ChatProvider, VoiceProvider>(
        builder: (context, chatProvider, voiceProvider, _) {
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
                  child: chatProvider.isLoading && chatProvider.chats.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    controller: _scrollController,
                    itemCount: chatProvider.chats.length,
                    itemBuilder: (context, index) {
                      final chat = chatProvider.chats[index];
                      final userMessage = chat.userMessage;
                      final consultantMessage = chat.consultantMessage;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (userMessage != null)
                            userMessage.text.startsWith("[audio]")
                                ? _buildAudioBubble(userMessage.text, true, voiceProvider)
                                : ChatBubble(text: userMessage.text, isUser: true),
                          if (consultantMessage != null)
                            consultantMessage.text.startsWith("[audio]")
                                ? _buildAudioBubble(consultantMessage.text, false, voiceProvider)
                                : ChatBubble(text: consultantMessage.text, isUser: false),
                        ],
                      );
                    },
                  ),
                ),
                if (chatProvider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      chatProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                _buildInputArea(chatProvider, voiceProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAudioBubble(String text, bool isUser, VoiceProvider voiceProvider) {
    final path = text.replaceFirst("[audio]", "");
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.green),
              onPressed: () => voiceProvider.playAudio(path),
            ),
            const Text("Audio Message"),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(ChatProvider chatProvider, VoiceProvider voiceProvider) {
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
              onSubmitted: (_) => _sendMessage(chatProvider),
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
          // Mic button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: voiceProvider.isRecording
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                voiceProvider.isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
              ),
              onPressed: () {
                voiceProvider.isRecording
                    ? voiceProvider.stopRecording()
                    : voiceProvider.startRecording();
              },
            ),
          ),
          // Send button
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
              onPressed: () => _sendMessage(chatProvider),
            ),
          ),
        ],
      ),
    );
  }
}
