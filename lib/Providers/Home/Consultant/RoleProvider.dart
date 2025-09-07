import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';
import '../../../../Models/Home/User/NavBar/FavoriteModel.dart';
import '../../../../Models/Home/User/Others/GetAllConsultant.dart';
import '../../../Models/Auth/RoleModel.dart';

class GetRole with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;
  RoleModel? _role;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;
  RoleModel? get role => _role;

  Future<void> getRole() async {
    _isLoading = true;
    _errorMessage = null;
    _role = null; // reset previous data
    notifyListeners();

    final String url = Endpoints.baseUrl + Endpoints.roleShowing;
    print("Fetching role from: $url");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    print("Token: $token");

    try {
      final response = await DioHelper.getData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        print(response.data);
        print(response.statusCode);
        print(url);

        _role = RoleModel.fromJson(response.data);
        _isSuccess = true;
        print("Parsed role: ${_role!.role}, email: ${_role!.email}");
      } else if (response.statusCode == 404) {
        _errorMessage = 'Role not found';
        print(_errorMessage);
      } else {
        _errorMessage =
        'Failed to fetch role (Error ${response.statusCode})';
        print(_errorMessage);
      }
    } catch (e, stacktrace) {
      _errorMessage = 'Failed to fetch role';
      print('Error fetching role: $e');
      print(stacktrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _isSuccess = false;
    _role = null;
    notifyListeners();
  }
}
