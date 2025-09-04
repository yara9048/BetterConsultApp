import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/Models/Home/User/Others/GeneralChatModel.dart';

import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';

class GeneralChatProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;
  List<GeneralChatModel> _chats = [];


  final List<Map<String, dynamic>> _messages = [];
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;
  List<GeneralChatModel> get chats => _chats;
  List<Map<String, dynamic>> get messages => _messages;

  void addUserMessage(String text) {
    _messages.add({'sender': 'user', 'message': text, 'type': 'text'});
    notifyListeners();
  }

  Future<void> generalChat(String question) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    String url = Endpoints.baseUrl + Endpoints.generalChat;

    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'question': question,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final data = response.data;

      if (data is Map && data.containsKey('consultants')) {
        final chat = GeneralChatModel.fromJson(response.data);
        _chats.add(chat);
        _isSuccess = true;

        for (var c in chat.consultants) {
          _messages.add({
            'sender': 'ai',
            'message': "${c.user.firstName} ${c.user.lastName}, ${c.description}",
            'type': 'consultant',
            'data': c,
          });
        }
      } else {
        _errorMessage = 'Unexpected response format';
      }
    } catch (e) {
      _errorMessage = 'Failed: $e';
      print("GeneralChat Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _isSuccess = false;
    _messages.clear();
    _chats.clear();
    notifyListeners();
  }
}
