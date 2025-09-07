import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';

class EditConsultantProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isVerified => _success;

  Future<void> editConsultantProfile({
    required int cost,
    required String firstName,
    required String lastName,
    required String location,
    required String email,
    required String description,
    required String title,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _success = false;
    notifyListeners();

    print("Starting editConsultantProfile...");

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        _errorMessage = "Auth token not found in SharedPreferences";
        print(_errorMessage);
        _isLoading = false;
        notifyListeners();
        return;
      }
      print("Retrieved token: $token");

      String url = Endpoints.baseUrl + Endpoints.editAndShowConsultantProfile;
      print("URL: $url");

      final requestData = {
        'cost': cost,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'location': location,
        'description': description,
        'title': title,
      };
      print("Request data: $requestData");

      final response = await DioHelper.patchData(
        url: url,
        data: requestData,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("Response received with status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        _success = true;
        print("Profile updated successfully");
      } else if (response.statusCode == 400) {
        _errorMessage = 'Invalid request data';
        print("Error 400: $_errorMessage");
      } else {
        _errorMessage = 'Failed with status code: ${response.statusCode}';
        print(_errorMessage);
      }
    } catch (e, stackTrace) {
      _errorMessage = 'Request failed: $e';
      print("Exception occurred: $e");
      print(stackTrace);
    }

    _isLoading = false;
    notifyListeners();
    print("Finished editConsultantProfile");
  }

  void reset() {
    _errorMessage = null;
    _success = false;
    _isLoading = false;
    notifyListeners();
    print("Provider state reset");
  }
}
