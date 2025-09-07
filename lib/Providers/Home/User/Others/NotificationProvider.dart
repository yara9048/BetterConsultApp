
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';

class NotificationProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isVerified => _success;


  Future<void> notification ({required int id,required String deviceToken}) async {
    _isLoading = true;
    _errorMessage = null;
    _success = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    String url = Endpoints.baseUrl + Endpoints.notifications;
    print(id);
    print(url);
    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'user_id': id,
          'token ': deviceToken,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode ==200) {
        _success = true;
        print("added");
      } else if (response.statusCode == 400) {
        _errorMessage = 'Invalid';
      } else {
        _errorMessage = 'Failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Request failed: $e';
      print(e);
    }

    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _success = false;
    _isLoading = false;
    notifyListeners();
  }
}
