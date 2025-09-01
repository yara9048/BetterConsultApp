import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/Models/Home/User/NavBar/ChatHistoryModel.dart';
import 'package:untitled6/Models/Home/User/Others/ChatHistoryContent.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/NavBar/FavoriteModel.dart';
import '../../../../Models/Home/User/Others/GetAllConsultant.dart';

class ChatHistoryContentProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<ChatHistoryContentModel> _chats = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ChatHistoryContentModel> get chats => _chats;

  Future<void> getChatsHistory({required int consultant_id}) async {
    _isLoading = true;
    _errorMessage = null;
    _chats = [];
    notifyListeners();


    final String url = Endpoints.baseUrl + Endpoints.chatHistoryContent;
    print(url);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    print(token);

    try {
      final response = await DioHelper.getData(
        url: url,
        data: {
          'consultant_id': consultant_id,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.data);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          _chats = data.map((item) => ChatHistoryContentModel.fromJson(item)).toList();
        } else if (data is Map && data['data'] is List) {
          _chats = (data['data'] as List).map((item) => ChatHistoryContentModel.fromJson(item)).toList();
        } else {
          _errorMessage = 'Unexpected response format';
        }
      }
      else if (response.statusCode == 404) {
        _errorMessage = 'No consultants here';
      }
      else {
        _errorMessage =
        'Failed to fetch consultants (Error ${response.statusCode})';
      }} catch (e, stacktrace) {
      _errorMessage = 'Failed to fetch consultants';
      print('Error fetching consultants: $e');
      print(stacktrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _chats = [];
    notifyListeners();
  }
}
