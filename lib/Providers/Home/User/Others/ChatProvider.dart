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

      print("🔹 Full raw response: ${response.data}");
      final data = response.data;

      if (data is Map) {
        print("✅ Response is a Map with keys: ${data.keys}");

        if (data.containsKey('chat')) {
          print("📌 Found 'chat' object with id: ${data['chat']['id']}");
        }
        if (data.containsKey('user_message')) {
          print("📌 Found 'user_message': ${data['user_message']}");
        }
        if (data.containsKey('consultant_message')) {
          print("📌 Found 'consultant_message': ${data['consultant_message']}");
        }
        if (data.containsKey('message_resources')) {
          print("📌 Found ${data['message_resources'].length} resources");
        }

        // Adjust this check based on real response
        if (data.containsKey('chat')) {
          print("✅ Accepting response as valid ChatModel input");
          _chats.add(ChatModel.fromJson(response.data));
          _isSuccess = true;
        } else {
          _errorMessage = 'Unexpected response structure: missing "chat"';
          print("❌ ERROR: $_errorMessage");
        }
      } else {
        _errorMessage = 'Unexpected response type: ${data.runtimeType}';
        print("❌ ERROR: $_errorMessage");
      }
    } catch (e, stack) {
      _errorMessage = 'Failed: $e';
      print("❌ Exception: $e");
      print("🔍 Stacktrace: $stack");
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
