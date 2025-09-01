
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';

class DeleteProfile with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isVerified => _success;

  Future<void> deleteAccount() async {
    _isLoading = true;
    _errorMessage = null;
    _success = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    String url = Endpoints.baseUrl + Endpoints.deleteProfile;
    try {
      final response = await DioHelper.deleteData(
        url: url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _success = true;
        print("deleted");
      } else if (response.statusCode == 404) {
        _errorMessage = 'Invalid';
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
