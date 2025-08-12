import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../DIO/DioHelper.dart';
import '../../DIO/EndPoints.dart';

class VerifyEmailProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isVerified = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isVerified => _isVerified;

  Future<void> verifyEmail(String email, String otp) async {
    _isLoading = true;
    _errorMessage = null;
    _isVerified = false;
    notifyListeners();

    String url = Endpoints.baseUrl + Endpoints.verifyOTP;
    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
        }
        _isVerified = true;
      } else if (response.statusCode == 400) {
        _errorMessage = 'Invalid OTP';
      } else {
        _errorMessage = 'Failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _errorMessage = null;
    _isVerified = false;
    _isLoading = false;
    notifyListeners();
  }
}
