import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../DIO/DioHelper.dart';
import '../../DIO/EndPoints.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;
  String? _role; // <-- store role here

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;
  String? get role => _role; // <-- public getter

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    String url = Endpoints.baseUrl + Endpoints.login;
    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        String token = response.data['token'];
        _role = response.data['user']?['role']?.toString();
        print('roleeeeeeeeeeee $_role');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_role', _role!); // optional: persist role

        _isSuccess = true;
      } else if (response.statusCode == 401) {
        _errorMessage = 'Invalid login information';
      } else {
        _errorMessage = 'Failed with status code: ${response.statusCode}';
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
    _role = null; // reset role if needed
    notifyListeners();
  }
}
