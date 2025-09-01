import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../DIO/DioHelper.dart';
import '../../DIO/EndPoints.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<void> register({
    required String gender,
    required String role,
    required String password,
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();
    String url = Endpoints.baseUrl + Endpoints.register;
    print(url);
    print(email);
    print(password);
    print(gender);
    print(role);
    print(firstName);
    print(phoneNumber);
    print(lastName);
    try {
      final response = await DioHelper.postData(
        url: url,
        data: {
          'email': email,
          'password': password,
          'gender': gender,
          'role': role,
          'phone_number': phoneNumber,
          'last_name': lastName,
          'first_name': firstName,
        },
      );

      if (response.statusCode == 201) {
        final token = response.data['token'];
        if (token != null) {
          String token = response.data['token'];
          final String? role = response.data['user']?['role']?.toString();
          final String? name = response.data['user']?['first_name']?.toString();
          final String? id = response.data['user']?['id']?.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          await prefs.setString('user_role', role!);
          await prefs.setString('user_name', name!);
          await prefs.setString('user_id', id!);

          print('Token saved: $token');

          print(response);
        }
        _isSuccess = true;
        _isSuccess = true;
      } else if (response.statusCode == 400) {
        _errorMessage = 'Invalid email';
      } else {
        _errorMessage = 'Registering failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Registering failed: $e';
      print(e);
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
