import 'package:flutter/material.dart';
import '../../DIO/DioHelper.dart';
import '../../DIO/EndPoints.dart';

class SendOTPProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<void> sendOTP(String email) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    String url = Endpoints.baseUrl + Endpoints.sendOTP;
    try {
      final response = await DioHelper.postData(
        url: url,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        _isSuccess = true;
      } else {
        _errorMessage = 'Failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed: $e';
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
