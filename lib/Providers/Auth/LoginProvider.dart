import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../DIO/DioHelper.dart';
import '../../DIO/EndPoints.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    String url = Endpoints.baseUrl + Endpoints.login;
    print(url);
    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'email': email,
          'password': password,
        },
      );
      print(email);
      print(password);
      if (response.statusCode == 200) {
        String token = response.data['token'];
        final String? role = response.data['user']?['role']?.toString();
        final String? name = response.data['user']?['first_name']?.toString();
        print(name);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_role', role!);
        await prefs.setString('user_name', name!);


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
    notifyListeners();
  }
}
