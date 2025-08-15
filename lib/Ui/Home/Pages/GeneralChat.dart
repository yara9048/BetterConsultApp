import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../Components/ChatBubble.dart';

class Generalchat extends StatefulWidget {
  const Generalchat({Key? key}) : super(key: key);

  @override
  State<Generalchat> createState() => _GeneralchatState();
}

class _GeneralchatState extends State<Generalchat> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'message': text});
      _controller.clear();
    });

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add({'sender': 'ai', 'message': 'AI response to: $text'});
      });
      _scrollToBottom();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(   backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text(
              S.of(context).generalChat,
              style: TextStyle(
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
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  text: message['message']!,
                  isUser: message['sender'] == 'user',
                );
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: _sendMessage,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15,
                fontFamily: 'NotoSerifGeorgian',
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: S.of(context).chatHint,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  fontSize: 15,
                  fontFamily: 'NotoSerifGeorgian',
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(width: 4),
          IconButton(
            icon:  Icon(Icons.send,color: Theme.of(context).colorScheme.primary,size: 30,),
            onPressed: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}
