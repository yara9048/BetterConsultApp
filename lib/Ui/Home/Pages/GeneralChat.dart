import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/Home/User/Others/GeneralChatPovider.dart';
import '../../../generated/l10n.dart';
import '../Components/ChatBubble.dart';
import 'ConsultantDetails.dart';

class Generalchat extends StatefulWidget {
  const Generalchat({Key? key}) : super(key: key);

  @override
  State<Generalchat> createState() => _GeneralchatState();
}

class _GeneralchatState extends State<Generalchat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(BuildContext context, String text) {
    if (text.trim().isEmpty) return;

    final provider = Provider.of<GeneralChatProvider>(context, listen: false);

    // Add user bubble immediately
    provider.addUserMessage(text);

    // Call API
    provider.generalChat(text).then((_) {
      _scrollToBottom();
    });

    _controller.clear();
    _scrollToBottom();
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
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              S.of(context).generalChat,
              style: const TextStyle(
                fontFamily: 'NotoSerifGeorgian',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
      body: Consumer<GeneralChatProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    final msg = provider.messages[index];
                    return GestureDetector(
                      onTap: () {
                        if (msg['type'] == 'consultant') {
                          final consultant = msg['data'];
                          Navigator.push(context, MaterialPageRoute(builder: (context) {return ConsultantDetails(id:consultant.id);}));
                      }
                      },
                      child: ChatBubble(
                        text: msg['message']!,
                        isUser: msg['sender'] == 'user',
                      ),
                    );
                  },
                ),
              ),
              _buildInputArea(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (text) => _sendMessage(context, text),
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
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary, size: 30),
            onPressed: () => _sendMessage(context, _controller.text),
          ),
        ],
      ),
    );
  }
}
