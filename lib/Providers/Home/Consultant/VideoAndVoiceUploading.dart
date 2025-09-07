import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../../DIO/DioHelper.dart';
import '../../../DIO/EndPoints.dart';

class VideoAndVoiceUploading with ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  // Store the last response JSON (success or error)
  Map<String, dynamic>? lastResponseData;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;

  Future<void> videoAndVoiceUploading(File file, {required bool isVideo}) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    lastResponseData = null;
    notifyListeners();

    final fileName = isVideo ? "video.mp4" : "audio.m4a";
    final String url = Endpoints.baseUrl + Endpoints.videoAndVoiceUploading;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      final response = await DioHelper.postData(
        url: url,
        headers: {'Authorization': 'Bearer $token'},
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        }),
      );

      // ✅ Always print raw response & status
      print("Upload response: ${response.data}");
      print("Status code: ${response.statusCode}");

      if (response.statusCode == 201) {
        _isSuccess = true;
        lastResponseData = Map<String, dynamic>.from(response.data);
      } else {
        _errorMessage = 'Upload failed with status ${response.statusCode}';
        if (response.data is Map<String, dynamic>) {
          lastResponseData = Map<String, dynamic>.from(response.data);
        }
      }
    } catch (e, stacktrace) {
      _errorMessage = 'Failed to upload file';

      if (e is DioError) {
        // ✅ Print server response even on error codes like 400, 404, 500...
        print("DioError status: ${e.response?.statusCode}");
        print("DioError data: ${e.response?.data}");

        if (e.response?.data is Map<String, dynamic>) {
          lastResponseData = Map<String, dynamic>.from(e.response!.data);
        }
      }

      print('Error uploading file: $e');
      print(stacktrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _errorMessage = null;
    _isLoading = false;
    _isSuccess = false;
    lastResponseData = null;
    notifyListeners();
  }
}
