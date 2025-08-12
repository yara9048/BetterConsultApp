import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../DIO/DioHelper.dart';
import '../../DIO/EndPoints.dart';

class Logoutprovider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      if (token.isEmpty) {
        _errorMessage = 'No token found';
        _isLoading = false;
        notifyListeners();
        return;
      }

      String url = Endpoints.baseUrl + Endpoints.logout;

      final response = await DioHelper.postData(
        url: url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('auth_token');
        _isSuccess = true;
      } else if (response.statusCode == 401) {
        _errorMessage = 'Invalid token given';
      } else {
        _errorMessage = 'Logout failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Logout failed: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();
  }
}
