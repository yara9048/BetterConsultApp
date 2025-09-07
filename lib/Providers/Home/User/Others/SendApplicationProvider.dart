import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../../../DIO/DioHelper.dart';
import '../../../../DIO/EndPoints.dart';

class SendApplicationProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<void> sendApplication({
    required String location,
    required String description,
    required String cost,
    required String domain,
    required String subDomain,
    required String yearsExperience,
    required String languages,
    required List<File> files,
    required File photo_file,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    String url = Endpoints.baseUrl + Endpoints.sendApplication;

    try {
      // Convert photo_file to MultipartFile
      final MultipartFile photoMultipart = await MultipartFile.fromFile(
        photo_file.path,
        filename: photo_file.path.split('/').last,
      );

      FormData formData = FormData.fromMap({
        'location': location,
        'description': description,
        'cost': cost,
        'domain': domain,
        'sub_domain': subDomain,
        'years_experience': yearsExperience,
        'languages': languages,
        'photo_file': photoMultipart, // send as MultipartFile
        'files': [
          for (var file in files)
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
        ],
      });

      // Debug prints
      print("URL: $url");
      print("Files count: ${files.length}");
      print("Photo file: ${photo_file.path}");

      final response = await DioHelper.postData(
        url: url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isSuccess = true;
      } else if (response.statusCode == 400) {
        _errorMessage = 'Invalid request data';
      } else if (response.statusCode == 401) {
        _errorMessage = 'Unauthorized';
      } else {
        _errorMessage = 'Failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed: $e';
      print("Error: $e");
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
