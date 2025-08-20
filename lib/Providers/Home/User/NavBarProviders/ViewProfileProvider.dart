import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/Models/Home/User/NavBar/ViewProfileModel.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';

class ViewProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  ViewProfileModel? _profile;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  ViewProfileModel? get profile => _profile;

  Future<void> fetchProfile() async {
    _isLoading = true;
    _errorMessage = null;
    _profile = null;
    notifyListeners();
    String url = Endpoints.baseUrl + Endpoints.viewProfile;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    print(token);
    print(url);

    try {
      final response = await DioHelper.getData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
      );

      print(token);
      print(url);
      print(response.data);

      if (response.statusCode == 200) {
        if (response.data is String) {
          _profile = viewProfileModelFromJson(response.data);
        } else if (response.data is Map<String, dynamic>) {
          _profile = ViewProfileModel.fromJson(response.data);
        }
      } else {
        _errorMessage = 'Failed to fetch profile';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch profile: ${e.toString()}';
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _profile = null;
    notifyListeners();
  }
}
