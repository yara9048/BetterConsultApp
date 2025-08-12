import 'package:flutter/material.dart';
import '../../DIO/DioHelper.dart';
import '../../DIO/EndPoints.dart';

class NewPasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isVerified => _success;

  Future<void> ResetPassword(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _success = false;
    notifyListeners();

    String url = Endpoints.baseUrl + Endpoints.resetPassword;
    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'email': email,
          'new_password': password,
        },
      );

      if (response.statusCode == 200) {
        _success = true;
      } else if (response.statusCode == 404) {
        _errorMessage = 'Invalid email';
      } else {
        _errorMessage = 'Failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Request failed: $e';
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
