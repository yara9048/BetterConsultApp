import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/Models/Home/User/Others/ChatModel.dart';

import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/Others/ChatHistoryContent.dart';


class ChatProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;
  List<ChatModel> _chats = [];


  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;
  List<ChatModel> get chats => _chats;

  Future<void> chat(String consultant_id, String text) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    String url = Endpoints.baseUrl + Endpoints.chat;

    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'consultant_id': consultant_id,
          'text': text,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final data = response.data;

      if (data is Map && data.containsKey('chat_id')) {
        _chats.add(ChatModel.fromJson(response.data));
        _isSuccess = true;
      } else {
        _errorMessage = 'Unexpected response format';
      }
    } catch (e) {
      _errorMessage = 'Failed: $e';
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();
  }
}
